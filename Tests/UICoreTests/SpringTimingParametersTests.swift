// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class SpringTimingParametersTests: XCTestCase {
  func testDefaultState() {
    let parameters1: SpringTimingParameters = SpringTimingParameters()
    XCTAssertEqual(parameters1.initialVelocity, .zero)

    let parameters2: SpringTimingParameters =
        SpringTimingParameters(dampingRatio: 1.0)
    XCTAssertEqual(parameters2.initialVelocity, .zero)

    let parameters3: SpringTimingParameters =
        SpringTimingParameters(mass: 0.0, stiffness: 0.0, damping: 0.0,
                               initialVelocity: .zero)
    XCTAssertEqual(parameters3.initialVelocity, .zero)
  }

  static var allTests = [
    ("testDefaultState", testDefaultState)
  ]
}
