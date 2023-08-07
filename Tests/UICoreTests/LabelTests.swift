// Copyright © 2023 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class LabelTests: XCTestCase {
  func testAlignment() {
    let label: Label = Label(frame: .zero)

    // FIXME(compnerd) this should be `natural`
    XCTAssertEqual(label.textAlignment, .left)

    label.textAlignment = .right
    XCTAssertEqual(label.textAlignment, .right)
  }

  static var allTests = [
    ("testAlignment", testAlignment),
  ]
}

