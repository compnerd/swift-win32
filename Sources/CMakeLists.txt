add_library(Cassowary SHARED
  ../Packages/cassowary/Sources/Cassowary/Constraint.swift
  ../Packages/cassowary/Sources/Cassowary/Errors.swift
  ../Packages/cassowary/Sources/Cassowary/Expression.swift
  ../Packages/cassowary/Sources/Cassowary/Row.swift
  ../Packages/cassowary/Sources/Cassowary/Solver.swift
  ../Packages/cassowary/Sources/Cassowary/Strength.swift
  ../Packages/cassowary/Sources/Cassowary/Symbol.swift
  ../Packages/cassowary/Sources/Cassowary/Symbolics.swift
  ../Packages/cassowary/Sources/Cassowary/Term.swift
  ../Packages/cassowary/Sources/Cassowary/Variable.swift)
swift_install(TARGETS Cassowary)

add_library(SwiftCOM SHARED
  ../Packages/SwiftCOM/Sources/SwiftCOM/COMBase.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Shell.swift)
target_sources(SwiftCOM PRIVATE
  ../Packages/SwiftCOM/Sources/SwiftCOM/Extensions/COMTypes+Extensions.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Extensions/String+Extensions.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Extensions/WinSDK+Extensions.swift)
target_sources(SwiftCOM PRIVATE
  ../Packages/SwiftCOM/Sources/SwiftCOM/Implementation/Human/IFileOperationProgressSink.swift)
target_sources(SwiftCOM PRIVATE
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IBindCtx.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IEnumMoniker.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IEnumString.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IEnumUnknown.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IErrorLog.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IFileOperation.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IMalloc.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IMoniker.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IObjectWithPropertyKey.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IOperationsProgressDialog.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPersist.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPersistStream.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPropertyBag2.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPropertyChange.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPropertyChangeArray.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IRunningObjectTable.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IShellItem.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IStream.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmap.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapClipper.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapCodecInfo.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapDecoder.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapDecoderInfo.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapEncoder.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapEncoderInfo.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapFlipRotator.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapFrameDecode.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapFrameEncode.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapLock.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapScaler.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapSource.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICColorContext.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICColorTransform.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICComponentInfo.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICFastMetadataEncoder.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICFormatConverter.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICImagingFactory.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICMetadataQueryReader.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICMetadataQueryWriter.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICPalette.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICStream.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeComp.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeInfo.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeLib.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/IUnknown.swift)
target_sources(SwiftCOM PRIVATE
  ../Packages/SwiftCOM/Sources/SwiftCOM/Support/Error.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Support/RawTyped.swift)
target_link_libraries(SwiftCOM PUBLIC
  Ole32)
set_target_properties(SwiftCOM PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
swift_install(TARGETS SwiftCOM)

add_subdirectory(CWinRT)
add_subdirectory(SwiftWin32)
add_subdirectory(SwiftWin32UI)
