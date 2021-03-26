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

  func testLayoutConstraintActivate() {
    let view: View = View(frame: .zero)
    let container: View = View(frame: .zero)

    withExtendedLifetime(view) {
      let constraint: LayoutConstraint =
          LayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                           toItem: container, attribute: .top, multiplier: 1,
                           constant: 100)
      constraint.isActive = true
      XCTAssertTrue(constraint.isActive)
    }
  }

  func testLayoutConstraintActivateList() {
    let view: View = View(frame: .zero)
    let container: View = View(frame: .zero)

    withExtendedLifetime(view) {
      let constraints: [LayoutConstraint] = [
        LayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                          toItem: container, attribute: .top, multiplier: 1,
                          constant: 100)
      ]
      LayoutConstraint.activate(constraints)

      XCTAssertTrue(constraints[0].isActive)
    }
  }

  static var allTests = [
    ("testLayoutConstraintInactiveByDefault", testLayoutConstraintInactiveByDefault),
    ("testLayoutConstraintActivate", testLayoutConstraintActivate),
    ("testLayoutConstraintActivateList", testLayoutConstraintActivateList),
  ]
}
