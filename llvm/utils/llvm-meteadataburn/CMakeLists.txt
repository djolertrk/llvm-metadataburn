set(LLVM_LINK_COMPONENTS
  AllTargetsDescs
  AllTargetsInfos
  BinaryFormat
  BitReader
  BitWriter
  Core
  DebugInfoDWARF
  IRReader
  Linker
  Object
  Support
  TransformUtils
  IPO
  )

add_llvm_utility(llvm-meteadataburn
  llvm-meteadataburn.cpp

  DEPENDS
  intrinsics_gen
  )
