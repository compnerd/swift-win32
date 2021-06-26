// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class ResponderTests: XCTestCase {
  func testDefaultProperties() {
    let responder: Responder = Responder()
    XCTAssertNil(responder.next)
    XCTAssertFalse(responder.isFirstResponder)
    XCTAssertFalse(responder.canBecomeFirstResponder)
    XCTAssertTrue(responder.canResignFirstResponder)
  }

  static var allTests = [
    ("testDefaultProperties", testDefaultProperties),
  ]
}
