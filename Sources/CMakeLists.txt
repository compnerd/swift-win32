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
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeComp.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeInfo.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/ITypeLib.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Interfaces/IUnknown.swift)
target_sources(SwiftCOM PRIVATE
  ../Packages/SwiftCOM/Sources/SwiftCOM/Support/Error.swift
  ../Packages/SwiftCOM/Sources/SwiftCOM/Support/RawTyped.swift)
target_link_libraries(SwiftCOM PUBLIC
  Ole32)
swift_install(TARGETS SwiftCOM)

add_subdirectory(CWinRT)
add_subdirectory(SwiftWin32)
