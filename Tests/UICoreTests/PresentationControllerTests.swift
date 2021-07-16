// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import SwiftWin32

final class PresentationControllerTests: XCTestCase {
  func testDefaultProperties() {
    let presentedViewController: ViewController = ViewController()
    let presentingViewController: ViewController = ViewController()
    let controller: PresentationController =
        PresentationController(presentedViewController: presentedViewController,
                               presenting: presentingViewController)

    XCTAssertNil(controller.delegate)
    XCTAssertTrue(controller.presentingViewController === presentingViewController)
    XCTAssertTrue(controller.presentedViewController === presentedViewController)
    XCTAssertNil(controller.overrideTraitCollection)
    XCTAssertTrue(controller.shouldPresentInFullscreen)
    XCTAssertFalse(controller.shouldRemovePresentersView)
  }

  static var allTests = [
    ("testDefaultProperties", testDefaultProperties),
  ]
}
