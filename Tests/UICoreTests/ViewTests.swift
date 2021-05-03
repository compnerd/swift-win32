// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest

import SwiftWin32

final class ViewCoordinateSpaceTests: XCTestCase {
  // TODO(compnerd) Add additional tests
  // TODO(compnerd) This should be renamed to be more precise
  func testConvertPoint() {
    let parent: View =
        View(frame: Rect(x: 0.0, y: 0.0, width: 1024.0, height: 768.0))
    let first: View =
        View(frame: Rect(x: 4.0, y: 92.0, width: 254.0, height: 17.0))
    let second: View =
        View(frame: Rect(x: 4.0, y: 113.0, width: 254.0, height: 17.0))

    parent.addSubview(first)
    parent.addSubview(second)

    XCTAssertEqual(first.convert(first.bounds.origin, to: second),
                   Point(x: 0.0, y: -21.0))
  }

  static var allTests = [
    ("testConvertPoint", testConvertPoint)
  ]
}
