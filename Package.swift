// swift-tools-version:5.3

import PackageDescription

let SwiftWin32 = Package(
  name: "SwiftWin32",
  products: [
    .library(name: "SwiftWin32", type: .dynamic, targets: ["SwiftWin32"]),
    .library(name: "SwiftWin32UI", type: .dynamic, targets: ["SwiftWin32UI"]),
    .executable(name: "UICatalog", targets: ["UICatalog"]),
    .executable(name: "Calculator", targets: ["Calculator"]),
    .executable(name: "HelloWorld", targets: ["HelloWorld"]),
  ],
  dependencies: [
    // NOTE(compnerd) require main as no current release has support for the
    // new CRT module.
    .package(url: "https://github.com/apple/swift-log.git", .branch("main")),
    .package(url: "https://github.com/compnerd/cassowary.git", .branch("master")),
    .package(name: "SwiftCOM", url: "https://github.com/compnerd/swift-com.git",
             .branch("master")),
  ],
  targets: [
    .target(
      name: "SwiftWin32",
      dependencies: [
        .product(name: "Logging", package: "swift-log"),
        .product(name: "cassowary", package: "cassowary"),
        .product(name: "SwiftCOM", package: "SwiftCOM"),
      ],
      path: "Sources/SwiftWin32",
      exclude: [
        "CMakeLists.txt",
      ],
      swiftSettings: [
        .define("WITH_SWIFT_LOG"),
        .unsafeFlags(["-Xfrontend", "-validate-tbd-against-ir=none"]),
      ],
      linkerSettings: [
        .linkedLibrary("User32"),
        .linkedLibrary("ComCtl32"),
      ]
    ),
    .target(
      name: "SwiftWin32UI",
      dependencies: [
        "SwiftWin32",
      ],
      path: "Sources/SwiftWin32UI"
    ),
    .target(
      name: "Calculator",
      dependencies: [
        "SwiftWin32",
      ],
      path: "Examples/Calculator",
      exclude: [
        "CMakeLists.txt",
        "Calculator.exe.manifest",
        "Info.plist",
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
        "Info.plist",
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
        "Info.plist",
        "UICatalog.exe.manifest",
      ],
      resources: [
        .copy("Assets/CoffeeCup.jpg"),
      ],
      swiftSettings: [
        .unsafeFlags([
          "-parse-as-library",
        ]),
      ]
    ),
  ]
)
