// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import SwiftWin32

final class BarItemTests : XCTestCase {
  func testDefaultState() {
    let item = BarItem()
    XCTAssertNil(item.title)
    XCTAssertNil(item.image)
    XCTAssertNil(item.landscapeImage)
    XCTAssertNil(item.largeContentSizeImage)
    XCTAssertEqual(item.imageInsets, .zero)
    XCTAssertEqual(item.landscapeImageInsets, .zero)
    XCTAssertEqual(item.largeContentSizeImageInsets, .zero)
    XCTAssertTrue(item.isEnabled)
    XCTAssertEqual(item.id, 0)
  }

  static var allTests = [
    ("testDefaultState", testDefaultState)
  ]
}
