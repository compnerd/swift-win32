// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import SwiftWin32

final class BarBttonItemTests: XCTestCase {
  func testDefaultState() {
    let item: BarButtonItem = BarButtonItem()
    XCTAssertNil(item.target)
    /* XCTAssertNil(item.action) */
    XCTAssertEqual(item.style, .plain)
    XCTAssertNil(item.possibleTitles)
    XCTAssertEqual(item.width, 0.0)
    XCTAssertNil(item.customView)
    XCTAssertNil(item.menu)
    XCTAssertNil(item.primaryAction)
    XCTAssertNil(item.primaryAction)
    XCTAssertNil(item.buttonGroup)
  }

  static var allTests = [
    ("testDefaultState", testDefaultState)
  ]
}
