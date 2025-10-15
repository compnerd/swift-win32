// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import WinSDK
@testable import SwiftWin32

final class TextViewTests: XCTestCase {
  static var hModule: HMODULE?

  override class func setUp() {
    TextViewTests.hModule = "Msftedit.dll".withCString(encodedAs: UTF16.self) {
      LoadLibraryW($0)
    }
  }

  func testConstruct() throws {
    try XCTSkipIf(TextViewTests.hModule == nil, "Msftedit.dll not loaded")

    let view: TextView = TextView(frame: .zero)
    XCTAssertNotEqual(view.hWnd, INVALID_HANDLE_VALUE)
  }

  static var allTests = [
    ("testConstruct", testConstruct),
  ]
}
