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

add_subdirectory(CWinRT)
add_subdirectory(SwiftWin32)
