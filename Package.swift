// swift-tools-version:5.4

import PackageDescription

#if swift(>=5.7)
let ExcludedPaths: [String] = [
  "CoreAnimation"
]
let SplitDependencies: [Target.Dependency] = [
  "CoreAnimation"
]
let SplitTargets: [Target] = [
  .target(
    name: "CoreAnimation",
    path: "Sources/SwiftWin32/CoreAnimation"
  ),
]
#else
let ExcludedPaths: [String] = []
let SplitDependencies: [Target.Dependency] = []
let SplitTargets: [Target] = []
#endif

let SwiftWin32 = Package(
  name: "SwiftWin32",
  products: [
    .library(name: "SwiftWin32", type: .dynamic, targets: ["SwiftWin32"]),
    .library(name: "SwiftWin32UI", type: .dynamic, targets: ["SwiftWin32UI"]),
    .executable(name: "UICatalog", targets: ["UICatalog"]),
    .executable(name: "Calculator", targets: ["Calculator"]),
  ],
  dependencies: [
    // NOTE(compnerd) require main as no current release has support for the
    // new CRT module.
    .package(url: "https://github.com/apple/swift-log.git", .branch("main")),
    .package(url: "https://github.com/apple/swift-collections.git",
             .upToNextMinor(from: "1.0.0")),
    .package(url: "https://github.com/compnerd/cassowary.git", .branch("main")),
    .package(name: "SwiftCOM", url: "https://github.com/compnerd/swift-com.git",
             .revision("ebbc617d3b7ba3a2023988a74bebd118deea4cc5")),
  ],
  targets: SplitTargets + [
    .target(
      name: "SwiftWin32",
      dependencies: SplitDependencies + [
        .product(name: "Logging", package: "swift-log"),
        .product(name: "OrderedCollections", package: "swift-collections"),
        .product(name: "cassowary", package: "cassowary"),
        .product(name: "SwiftCOM", package: "SwiftCOM"),
      ],
      path: "Sources/SwiftWin32",
      exclude: ExcludedPaths + ["CMakeLists.txt"],
      linkerSettings: [
        .linkedLibrary("User32"),
        .linkedLibrary("ComCtl32"),
      ]
    ),
    .target(
      name: "SwiftWin32UI",
      dependencies: ["SwiftWin32"],
      path: "Sources/SwiftWin32UI",
      exclude: ["CMakeLists.txt"]
    ),
    .executableTarget(
      name: "Calculator",
      dependencies: ["SwiftWin32"],
      path: "Examples/Calculator",
      exclude: [
        "CMakeLists.txt",
        "Calculator.exe.manifest",
        "Info.plist",
      ],
      swiftSettings: [.unsafeFlags(["-parse-as-library"])]
    ),
    .executableTarget(
      name: "UICatalog",
      dependencies: ["SwiftWin32"],
      path: "Examples/UICatalog",
      exclude: [
        "CMakeLists.txt",
        "Info.plist",
        "UICatalog.exe.manifest",
      ],
      resources: [.copy("Assets/CoffeeCup.jpg")],
      swiftSettings: [.unsafeFlags(["-parse-as-library"])]
    ),
    .target(name: "TestUtilities", path: "Tests/Utilities"),
    .testTarget(name: "AutoLayoutTests", dependencies: ["SwiftWin32"]),
    .testTarget(name: "CoreGraphicsTests", dependencies: ["SwiftWin32"]),
    .testTarget(name: "SupportTests", dependencies: ["SwiftWin32"]),
    .testTarget(
      name: "UICoreTests",
      dependencies: ["SwiftWin32", "TestUtilities"]
    )
  ]
)
