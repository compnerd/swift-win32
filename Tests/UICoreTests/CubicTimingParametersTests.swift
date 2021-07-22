// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class CubicTimingParametersTests: XCTestCase {
  func testDefaultState() {
    let parameters1: CubicTimingParameters = CubicTimingParameters()
    XCTAssertEqual(parameters1.animationCurve, .linear)
    XCTAssertEqual(parameters1.controlPoint1, .zero)
    XCTAssertEqual(parameters1.controlPoint1, Point(x: 1, y: 1))

    let parameters2: CubicTimingParameters =
        CubicTimingParameters(animationCurve: .linear)
    XCTAssertEqual(parameters2.animationCurve, .linear)
    XCTAssertEqual(parameters2.controlPoint1, .zero)
    XCTAssertEqual(parameters2.controlPoint2, .zero)

    let parameters3: CubicTimingParameters =
        CubicTimingParameters(controlPoint1: .zero, controlPoint2: .zero)
    XCTAssertEqual(parameters3.animationCurve, .linear)
    XCTAssertEqual(parameters3.controlPoint1, .zero)
    XCTAssertEqual(parameters3.controlPoint2, .zero)
  }

  static var allTests = [
    ("testDefaultState", testDefaultState)
  ]
}
