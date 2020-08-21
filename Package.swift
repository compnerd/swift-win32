// swift-tools-version:5.3

import PackageDescription

let SwiftWin32 = Package(
  name: "SwiftWin32",
  products: [
    .library(name: "SwiftWin32", type: .dynamic, targets: ["SwiftWin32"]),
    .executable(name: "Calculator", targets: ["Calculator"]),
  ],
  targets: [
    .target(
      name: "SwiftWin32",
      path: "Sources",
      exclude: [
        "CMakeLists.txt",
        "CWinRT",
      ],
      cSettings: [
        .define("COBJMACROS"),
        .define("NONAMELESSUNION"),
      ],
      linkerSettings: [
        .linkedLibrary("User32"),
        .linkedLibrary("ComCtl32"),
      ]
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
          "-parse-as-library"
        ]),
      ]
    ),
  ]
)
