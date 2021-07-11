// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import SwiftWin32

final class OffsetTests: XCTestCase {
  func testOffsetConstructor() {
    XCTAssertEqual(Offset(), .zero)

    let offset: Offset = Offset(horizontal: .infinity, vertical: .infinity)
    XCTAssertEqual(offset.horizontal, .infinity)
    XCTAssertEqual(offset.vertical, .infinity)
  }

  func testOffsetStringForOffset() {
    XCTAssertEqual(Offset.offset(for: "invalid"), .zero)
    XCTAssertEqual(Offset.offset(for: "{"), .zero)
    XCTAssertEqual(Offset.offset(for: "{1"), .zero)
    XCTAssertEqual(Offset.offset(for: "{1,"), .zero)
    XCTAssertEqual(Offset.offset(for: "{1,1"), .zero)
    XCTAssertEqual(Offset.offset(for: "{1,1}"), Offset(horizontal: 1, vertical: 1))
  }

  func testOffsetStringRoundtrip() {
    let offset: Offset = Offset(horizontal: 1, vertical: 2)
    let string: String = Offset.string(for: offset)
    XCTAssertEqual(string, "{1.0000000000000, 2.0000000000000}")
    XCTAssertEqual(offset, Offset.offset(for: string))
  }

  static var allTests = [
    ("testOffsetConstructor", testOffsetConstructor),
    ("testOffsetStringForOffset", testOffsetStringForOffset),
    ("testOffsetStringRoundtrip", testOffsetStringRoundtrip),
  ]
}
