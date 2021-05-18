// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class ViewControllerTests: XCTestCase {
  func testLazyViewLoading() {
    let sut = ViewController()

    XCTAssertNil(sut.viewIfLoaded)
    XCTAssertFalse(sut.isViewLoaded)

    _ = sut.view

    XCTAssertNotNil(sut.viewIfLoaded)
    XCTAssertTrue(sut.isViewLoaded)
  }

  func testManualViewLoading() {
    let sut = ViewController()

    XCTAssertNil(sut.viewIfLoaded)
    XCTAssertFalse(sut.isViewLoaded)

    sut.loadViewIfNeeded()

    XCTAssertNotNil(sut.viewIfLoaded)
    XCTAssertTrue(sut.isViewLoaded)
  }
}
