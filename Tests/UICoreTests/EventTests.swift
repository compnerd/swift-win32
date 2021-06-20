// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class EventTests: XCTestCase {
  func testConstructPressesEvent() {
    let event: Event = .init(type: .presses, subtype: .none, timestamp: 0)
    XCTAssertEqual(event.buttonMask, [])
    XCTAssertEqual(event.modifierFlags, [])
    XCTAssertEqual(event.timestamp, 0)
  }

  static var allTests = [
    ("testConstructPressesEvent", testConstructPressesEvent)
  ]
}
