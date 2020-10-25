// swift-tools-version:5.3

import PackageDescription

let SwiftWin32 = Package(
  name: "SwiftWin32",
  products: [
    .library(name: "SwiftWin32", type: .dynamic, targets: ["SwiftWin32"]),
    .library(name: "SwiftUIWin32", type: .dynamic, targets: ["SwiftUIWin32"]),
    .executable(name: "UICatalog", targets: ["UICatalog"]),
    .executable(name: "Calculator", targets: ["Calculator"]),
    .executable(name: "HelloWorld", targets: ["HelloWorld"]),
  ],
  dependencies: [
    // NOTE(compnerd) require main as no current release has support for the
    // new CRT module.
    .package(url: "https://github.com/apple/swift-log.git", .branch("main")),
    .package(url: "https://github.com/compnerd/cassowary.git", .branch("master")),
  ],
  targets: [
    .target(
      name: "SwiftWin32",
      dependencies: [
        .product(name: "Logging", package: "swift-log"),
        .product(name: "cassowary", package: "cassowary")
      ],
      path: "Sources",
      exclude: [
        "CMakeLists.txt",
        "CWinRT",
        "SwiftUIWin32",
      ],
      cSettings: [
        .define("COBJMACROS"),
        .define("NONAMELESSUNION"),
      ],
      swiftSettings: [
        .define("WITH_SWIFT_LOG"),
      ],
      linkerSettings: [
        .linkedLibrary("User32"),
        .linkedLibrary("ComCtl32"),
      ]
    ),
    .target(
      name: "SwiftUIWin32",
      dependencies: [
        "SwiftWin32",
      ],
      path: "Sources/SwiftUIWin32"
    ),
    .target(
      name: "Calculator",
      dependencies: [
        "SwiftWin32",
      ],
      path: "Examples/Calculator",
      exclude: [
        "CMakeLists.txt",
      ],
      swiftSettings: [
        .unsafeFlags([
          "-parse-as-library",
        ]),
      ]
    ),
    .target(
      name: "HelloWorld",
      dependencies: [
        "SwiftWin32",
      ],
      path: "Examples/HelloWorld",
      exclude: [
        "CMakeLists.txt",
      ],
      swiftSettings: [
        .unsafeFlags([
          "-parse-as-library",
        ]),
      ]
    ),
    .target(
      name: "UICatalog",
      dependencies: [
        "SwiftWin32",
      ],
      path: "Examples/UICatalog",
      exclude: [
        "CMakeLists.txt",
      ],
      swiftSettings: [
        .unsafeFlags([
          "-parse-as-library",
        ]),
      ]
    ),
  ]
)
