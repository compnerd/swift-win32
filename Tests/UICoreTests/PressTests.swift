// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class PressTests: XCTestCase {
  func testPressEquality() {
    let p: Press = .init(type: .select, phase: .began, force: 0.0, timestamp: 0)
    XCTAssertEqual(p, p)

    // FIXME(compnerd) is this correct?
    let q: Press = .init(type: .select, phase: .began, force: 0.0, timestamp: 0)
    XCTAssertNotEqual(p, q)
  }

  static var allTests = [
    ("testPressEquality", testPressEquality),
  ]
}
