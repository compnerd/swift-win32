// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import WinSDK
@testable import SwiftWin32

final class ButtonTests: XCTestCase {
  func testConstructWithAction() {
    let expectation: XCTestExpectation =
        self.expectation(description: "action is performed")

    let button: Button =
        Button(frame: .zero, primaryAction: Action { _ in
          expectation.fulfill()
        })

    // TODO(compnerd) migrate to UI automation API
    _ = SendMessageW(button.hWnd, UINT(WM_LBUTTONUP), 0, 0)

    // FIXME(compnerd) what is a good timeout value to use?
    waitForExpectations(timeout: 1)
  }

  static var allTests = [
    ("testConstructWithAction", testConstructWithAction),
  ]
}
