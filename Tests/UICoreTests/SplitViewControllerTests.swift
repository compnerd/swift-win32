// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class SplitViewControllerTests: XCTestCase {
  func testDefaultPropertiesUnspecified() {
    let controller: SplitViewController = SplitViewController()

    // NSError: "This API requires initializing via SplitViewController(style:)"

    XCTAssertEqual(controller.style, .unspecified)
    XCTAssertNil(controller.delegate)
    XCTAssertEqual(controller.viewControllers, [])
    XCTAssertEqual(controller.preferredDisplayMode, .automatic)
    XCTAssertEqual(controller.displayMode, .oneBesideSecondary)
    // Expected: SplitViewControllerDisplayModeBarButtonItem
    // controller.displayModeButtonItem
    XCTAssertTrue(controller.presentsWithGesture)
    // XCTAssertFalse(controller.showsSecondaryOnlyButton)
    // XCTAssertEqual(controller.displayModeButtonVisibility, .automatic)
    // XCTAssertEqual(controller.preferredSplitBehavior, .automatic)
    // XCTAssertEqual(controller.splitBehavior, .displace)
    XCTAssertEqual(controller.preferredPrimaryColumnWidthFraction, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.preferredPrimaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.primaryColumnWidth, Screen.main.bounds.width)
    XCTAssertEqual(controller.minimumPrimaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.maximumPrimaryColumnWidth, SplitViewController.automaticDimension)
    // XCTAssertEqual(controller.preferredSupplementaryColumnWidthFraction, SplitViewController.automaticDimension)
    // XCTAssertEqual(controller.preferredSupplementaryColumnWidth, SplitViewController.automaticDimension)
    // XCTAssertEqual(controller.supplementaryColumnWidth, 0.0)
    // XCTAssertEqual(controller.minimumSupplementaryColumnWidth, SplitViewController.automaticDimension)
    // XCTAssertEqual(controller.maximumSupplementaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.primaryEdge, .leading)
    XCTAssertEqual(controller.primaryBackgroundStyle, .none)
  }

  func testDefaultPropertiesDoubleColumn() {
    let controller: SplitViewController = SplitViewController(style: .doubleColumn)

    // NSError: "SpitViewController suplementaryColumnWidth rpoeprties unsupported for style = DoubleColumn"

    XCTAssertEqual(controller.style, .doubleColumn)
    XCTAssertNil(controller.delegate)
    XCTAssertEqual(controller.viewControllers, [])
    XCTAssertEqual(controller.preferredDisplayMode, .automatic)
    XCTAssertEqual(controller.displayMode, .secondaryOnly)
    // controller.displayModeButtonItem
    XCTAssertTrue(controller.presentsWithGesture)
    XCTAssertFalse(controller.showsSecondaryOnlyButton)
    XCTAssertEqual(controller.displayModeButtonVisibility, .automatic)
    XCTAssertEqual(controller.preferredSplitBehavior, .automatic)
    XCTAssertEqual(controller.splitBehavior, .overlay)
    XCTAssertEqual(controller.preferredPrimaryColumnWidthFraction, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.preferredPrimaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.primaryColumnWidth, 0.0)
    XCTAssertEqual(controller.minimumPrimaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.maximumPrimaryColumnWidth, SplitViewController.automaticDimension)
    // XCTAssertEqual(controller.preferredSupplementaryColumnWidthFraction, SplitViewController.automaticDimension)
    // XCTAssertEqual(controller.preferredSupplementaryColumnWidth, SplitViewController.automaticDimension)
    // XCTAssertEqual(controller.supplementaryColumnWidth, 0.0)
    // XCTAssertEqual(controller.minimumSupplementaryColumnWidth, SplitViewController.automaticDimension)
    // XCTAssertEqual(controller.maximumSupplementaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.primaryEdge, .leading)
    XCTAssertEqual(controller.primaryBackgroundStyle, .none)
  }

  func testDefaultPropertiesTripleColumn() {
    let controller: SplitViewController = SplitViewController(style: .tripleColumn)

    XCTAssertEqual(controller.style, .tripleColumn)
    XCTAssertNil(controller.delegate)
    XCTAssertEqual(controller.viewControllers, [])
    XCTAssertEqual(controller.preferredDisplayMode, .automatic)
    XCTAssertEqual(controller.displayMode, .secondaryOnly)
    // controller.displayModeButtonItem
    XCTAssertTrue(controller.presentsWithGesture)
    XCTAssertFalse(controller.showsSecondaryOnlyButton)
    XCTAssertEqual(controller.displayModeButtonVisibility, .automatic)
    XCTAssertEqual(controller.preferredSplitBehavior, .automatic)
    XCTAssertEqual(controller.splitBehavior, .overlay)
    XCTAssertEqual(controller.preferredPrimaryColumnWidthFraction, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.preferredPrimaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.primaryColumnWidth, 0.0)
    XCTAssertEqual(controller.minimumPrimaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.maximumPrimaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.preferredSupplementaryColumnWidthFraction, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.preferredSupplementaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.supplementaryColumnWidth, 0.0)
    XCTAssertEqual(controller.minimumSupplementaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.maximumSupplementaryColumnWidth, SplitViewController.automaticDimension)
    XCTAssertEqual(controller.primaryEdge, .leading)
    XCTAssertEqual(controller.primaryBackgroundStyle, .none)
  }

  func testAutomaticResolution() {
    // minimumPrimaryColumnWidth is treated as 0.0
    XCTAssertEqual(SplitViewController.resolve(minimumPrimaryColumnWidth: SplitViewController.automaticDimension), 0.0)

    // maximumPrimaryColumnWidth is treated as 320.0
    XCTAssertEqual(SplitViewController.resolve(maximumPrimaryColumnWidth: SplitViewController.automaticDimension), 320.0)

    // minimumSupplementaryColumnWidth is treated as 0.0
    XCTAssertEqual(SplitViewController.resolve(minimumSupplementaryColumnWidth: SplitViewController.automaticDimension), 0.0)

    // maximumSupplementaryColumnWidth is treated as 320.0
    XCTAssertEqual(SplitViewController.resolve(maximumSupplementaryColumnWidth: SplitViewController.automaticDimension), 320.0)

    var traits: TraitCollection

    traits = TraitCollection(traitsFrom: [
      TraitCollection(horizontalSizeClass: .regular),
      TraitCollection(userInterfaceIdiom: .unspecified),
    ])
    // `.automatic` should never be returned for displayMode.
    XCTAssertNotEqual(SplitViewController.resolve(preferredDisplayMode: .automatic,
                                                  for: traits,
                                                  bounds: Screen.main.bounds),
                      .automatic)
    // `.automatic` should never be returned for splitBehavior.
    XCTAssertNotEqual(SplitViewController.resolve(preferredSplitBehavior: .automatic,
                                                  for: traits,
                                                  bounds: Screen.main.bounds),
                      .automatic)

    traits = TraitCollection(traitsFrom: [
      TraitCollection(horizontalSizeClass: .compact),
      TraitCollection(userInterfaceIdiom: .unspecified),
    ])
    // .oneOverSecondary if requested, else .oneBesideSecondary for compact layouts.
    XCTAssertEqual(SplitViewController.resolve(preferredDisplayMode: .oneOverSecondary,
                                               for: traits,
                                               bounds: Screen.main.bounds),
                   .oneOverSecondary)
    XCTAssertEqual(SplitViewController.resolve(preferredDisplayMode: .automatic,
                                               for: traits,
                                               bounds: Screen.main.bounds),
                   .oneBesideSecondary)
    // .tile if requested, else .overlay for compact layouts.
    XCTAssertEqual(SplitViewController.resolve(preferredSplitBehavior: .tile,
                                               for: traits,
                                               bounds: Screen.main.bounds),
                   .tile)
    XCTAssertEqual(SplitViewController.resolve(preferredSplitBehavior: .automatic,
                                               for: traits,
                                               bounds: Screen.main.bounds),
                   .overlay)

    traits = TraitCollection(traitsFrom: [
      TraitCollection(horizontalSizeClass: .unspecified),
      TraitCollection(userInterfaceIdiom: .tablet),
    ])
    // tablets should return .oneBesideSecondary unless width < height.
    XCTAssertEqual(SplitViewController.resolve(preferredDisplayMode: .automatic,
                                               for: traits,
                                               bounds: Rect(origin: .zero,
                                                            size: Size(width: 640,
                                                                       height: 480))),
                   .oneBesideSecondary)
    XCTAssertEqual(SplitViewController.resolve(preferredDisplayMode: .automatic,
                                               for: traits,
                                               bounds: Rect(origin: .zero,
                                                            size: Size(width: 480,
                                                                       height: 640))),
                   .oneOverSecondary)
    // tablets should prefer .allVisible when in landscape, everything should
    // prefer .primaryOverlay.
    XCTAssertEqual(SplitViewController.resolve(preferredSplitBehavior: .automatic,
                                               for: traits,
                                               bounds: Rect(origin: .zero,
                                                            size: Size(width: 640,
                                                                       height: 480))),
                   .overlay)
    XCTAssertEqual(SplitViewController.resolve(preferredSplitBehavior: .automatic,
                                               for: traits,
                                               bounds: Rect(origin: .zero,
                                                            size: Size(width: 480,
                                                                       height: 640))),
                   .displace)
  }

  static var allTests = [
    ("testDefaultPropertiesUnspecified", testDefaultPropertiesUnspecified),
    ("testDefaultPropertiesDoubleColumn", testDefaultPropertiesDoubleColumn),
    ("testDefaultPropertiesTripleColumn", testDefaultPropertiesTripleColumn),
    ("testAutomaticResolution", testAutomaticResolution),
  ]
}
