/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import XCTest

import SwiftWin32

final class AutoLayoutTests: XCTestCase {
  func testLayoutConstraintInactiveByDefault() {
    XCTAssertFalse(LayoutConstraint(item: self, attribute: .left,
                                    relatedBy: .equal,
                                    toItem: nil, attribute: .notAnAttribute,
                                    multiplier: 1.0, constant: 0.0).isActive)
  }

  static var allTests = [
    ("testLayoutConstraintInactiveByDefault", testLayoutConstraintInactiveByDefault),
  ]
}
