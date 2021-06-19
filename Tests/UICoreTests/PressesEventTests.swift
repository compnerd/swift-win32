// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class PressesEventTests: XCTestCase {
  func testConstruct() {
    let event: PressesEvent = .init(presses: [], timestamp: 0)
    XCTAssertEqual(event.type, .presses)
    XCTAssertEqual(event.subtype, .none)
    XCTAssertEqual(event.timestamp, 0)
  }

  static var allTests = [
    ("testConstruct", testConstruct),
  ]
}
