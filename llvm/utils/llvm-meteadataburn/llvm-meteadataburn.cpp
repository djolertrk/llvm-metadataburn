//===-- llvm-meteadataburn.cpp - Reduce LLVM metadata in tests ------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This program is a utility that works like metadata reducer for LLVM tests.
//
//===----------------------------------------------------------------------===//

#include "llvm/IR/AssemblyAnnotationWriter.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/WithColor.h"
#include "llvm/Support/raw_ostream.h"

#define DEBUG_TYPE "metadataburn"

using namespace llvm;

// @}
/// Command line options.
/// @{

namespace {
using namespace cl;

OptionCategory MetadataBurnCategory("Specific Options");
static opt<bool> Help("h", desc("Alias for -help"), Hidden,
                      cat(MetadataBurnCategory));
static opt<std::string> InputFilename(Positional, desc("<input LLVM IR file>"),
                                      cat(MetadataBurnCategory));
static opt<std::string>
    OutputFilename("out-file", cl::init("-"),
                   cl::desc("Redirect output to the specified file."),
                   cl::value_desc("filename"), cat(MetadataBurnCategory));
static alias OutputFilenameAlias("o", desc("Alias for -out-file."),
                                 aliasopt(OutputFilename),
                                 cat(MetadataBurnCategory));
static opt<bool> Override("override", cl::init(false),
                          cl::desc("Override input test file if reduced."),
                          cat(MetadataBurnCategory));
static opt<std::string> Lit("lit", cl::desc("Specify llvm-lit to be used."),
                            cat(MetadataBurnCategory));
} // namespace
/// @}
//===----------------------------------------------------------------------===//

// Here we cut off the metadata.
static bool burnFunction(Function &F) {
  if (F.isMaterializable())
    return false;

  auto SP = F.getSubprogram();
  if (!SP)
    return false;

  bool Result = false;
  llvm::DenseMap<llvm::DIScope *, llvm::DebugLoc> FirstLocInScope;
  for (BasicBlock &BB : F)
    for (Instruction &I : BB)
      // Handle debug-loc.
      if (I.getDebugLoc()) {
        auto DbgLoc = I.getDebugLoc();
        auto Scope = DbgLoc.get()->getScope();
        if (!FirstLocInScope.count(Scope))
          FirstLocInScope.insert({Scope, DbgLoc});
        else {
          Result = true;
          auto &ScopeLoc = FirstLocInScope[Scope];
          I.setDebugLoc(ScopeLoc);
        }

        // Strip tbaa.
        if (I.getMetadata(LLVMContext::MD_tbaa)) {
          Result = true;
          I.setMetadata(LLVMContext::MD_tbaa, nullptr);
        }
      }

  return Result;
}

void parseComments(StringRef &Data, SmallVectorImpl<std::string> &Comments) {
  SmallVector<StringRef, 8> Lines;
  Data.split(Lines, '\n');
  for (auto &L : Lines) {
    if (!L.startswith(";"))
      continue;
    if (L.startswith("; ModuleID"))
      continue;
    if (L.startswith("; Function Attrs:"))
      continue;

    Comments.push_back(std::string(L));
  }
}

// Execute the LLVM test with lit.
static std::string executeTest(const char *Command) {
  std::array<char, 128> BufferOut;
  std::string ResultOut;
  std::unique_ptr<FILE, decltype(&pclose)> Pipe(popen(Command, "r"), pclose);
  if (!Pipe) {
    WithColor::error(errs()) << "popen() failed!";
    return ResultOut;
  }

  while (fgets(BufferOut.data(), BufferOut.size(), Pipe.get()) != nullptr)
    ResultOut += BufferOut.data();

  return ResultOut;
}

int main(int argc, char **argv) {
  InitLLVM X(argc, argv);

  llvm::InitializeAllTargetInfos();
  llvm::InitializeAllTargetMCs();

  llvm::outs() << "=== LLVM metadata burn ===\n";

  HideUnrelatedOptions({&MetadataBurnCategory});
  cl::ParseCommandLineOptions(argc, argv,
                              "reduce metadata for an input LLVM IR file.\n");

  if (Help) {
    PrintHelpMessage(false, true);
    return 0;
  }

  if (InputFilename == "") {
    WithColor::error(errs()) << "no test input file\n";
    return 1;
  }

  if (Lit == "") {
    WithColor::error(errs()) << "no llvm-lit specified\n";
    return 1;
  }

  // Preserve comments.
  auto Buffer = MemoryBuffer::getFile(InputFilename);
  if (!Buffer) {
    WithColor::error(errs()) << "unable to parse the test file.\n";
    return 1;
  }

  StringRef Str = (*Buffer)->getBuffer();
  SmallVector<std::string, 8> Comments;
  parseComments(Str, Comments);

  // No CHECK lines found.
  if (!Comments.size()) {
    llvm::outs() << "Skipping test without CHECK lines.\n";
    return 0;
  }

  LLVMContext Ctxt;
  std::unique_ptr<Module> M;
  SMDiagnostic Err;

  M = parseIRFile(InputFilename, Err, Ctxt);

  NamedMDNode *CUNodes = M->getNamedMetadata("llvm.dbg.cu");
  if (!CUNodes) {
    llvm::outs() << "Skipping test without debug info.\n";
    return 0;
  }

  LLVM_DEBUG(for (Function &F : M->functions()) F.print(llvm::outs()););

  bool IsChanged = false;

  // Reduce the test file.
  llvm::SmallVector<Function *, 8> UnusedDecls;
  for (Function &F : M->functions()) {
    if (!F.isDeclaration()) {
      if (burnFunction(F))
        IsChanged = true;
      continue;
    }

    // Remove unused functions.
    if (F.use_empty()) {
      IsChanged = true;
      UnusedDecls.push_back(&F);
    }
  }

  for (auto *F : UnusedDecls)
    F->eraseFromParent();

  LLVM_DEBUG(llvm::dbgs() << "\nafter:\n";
             for (Function &F
                  : M->functions()) F.print(llvm::outs()););

  if (!IsChanged) {
    llvm::outs() << "Unable to reduce " << InputFilename << '\n';
    return 0;
  }

  if (!Override && OutputFilename == "") {
    OutputFilename = "reduced-test.ll";
  }

  StringRef FinalOutput = Override ? InputFilename : OutputFilename;

  // Write the final/reduced Module.
  std::error_code EC;
  std::unique_ptr<ToolOutputFile> Out(
      new ToolOutputFile(FinalOutput, EC, sys::fs::OF_TextWithCRLF));
  if (EC) {
    errs() << EC.message() << '\n';
    return 1;
  }

  // Write comments:
  //  ; RUN ...
  //  ; CHECK ...
  //  ;; This is ...
  for (const auto &C : Comments)
    Out->os() << C << '\n';
  Out->os() << '\n';

  std::unique_ptr<AssemblyAnnotationWriter> Annotator;
  M->print(Out->os(), Annotator.get());

  // If the test still passes, we will keep reduced file.
  std::string LitCommand("python3 ");
  LitCommand += Lit;
  LitCommand += " ";
  LitCommand += FinalOutput;

  std::string TestOutput = executeTest(LitCommand.c_str());
  if (TestOutput == "")
    return 1;

  if (TestOutput.find("PASS:") != std::string::npos) {
    // Declare success.
    llvm::outs() << "Reduced file generated: " << FinalOutput << '\n';
  } else {
    llvm::outs() << "Unable to reduce " << InputFilename << '\n';
  }

  Out->keep();
  return 0;
}
