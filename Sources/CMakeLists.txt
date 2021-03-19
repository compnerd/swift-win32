#[[
Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
All rights reserved.

SPDX-License-Identifier: BSD-3-Clause
#]]

add_library(Cassowary SHARED
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Constraint.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Errors.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Expression.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Row.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Solver.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Strength.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Symbol.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Symbolics.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Term.swift
  ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/Variable.swift)
_install_target(Cassowary)

add_library(SwiftCOM SHARED
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/COMBase.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Shell.swift)
target_sources(SwiftCOM PRIVATE
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Extensions/COMTypes+Extensions.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Extensions/String+Extensions.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Extensions/WinSDK+Extensions.swift)
target_sources(SwiftCOM PRIVATE
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Implementation/Human/IFileOperationProgressSink.swift)
target_sources(SwiftCOM PRIVATE
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IBindCtx.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IEnumMoniker.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IEnumString.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IEnumUnknown.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IErrorLog.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IFileOperation.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IMalloc.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IMoniker.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IObjectWithPropertyKey.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IOperationsProgressDialog.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPersist.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPersistStream.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPropertyBag2.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPropertyChange.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IPropertyChangeArray.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IRunningObjectTable.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IShellItem.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IStream.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmap.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapClipper.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapCodecInfo.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapDecoder.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapDecoderInfo.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapEncoder.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapEncoderInfo.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapFlipRotator.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapFrameDecode.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapFrameEncode.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapLock.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapScaler.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICBitmapSource.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICColorContext.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICColorTransform.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICComponentInfo.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICFastMetadataEncoder.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICFormatConverter.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICImagingFactory.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICMetadataQueryReader.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICMetadataQueryWriter.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICPalette.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/Human/IWICStream.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeComp.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeInfo.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeLib.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/IUnknown.swift)
target_sources(SwiftCOM PRIVATE
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Support/Error.swift
  ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/Support/RawTyped.swift)
target_link_libraries(SwiftCOM PUBLIC
  Ole32)
set_target_properties(SwiftCOM PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
_install_target(SwiftCOM)

add_subdirectory(CWinRT)
add_subdirectory(SwiftWin32)
add_subdirectory(SwiftWin32UI)
