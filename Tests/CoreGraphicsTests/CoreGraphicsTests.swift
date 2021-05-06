// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest

import SwiftWin32

final class CoreGraphicsTests: XCTestCase {
  func testAffineTransformIdentity() {
    let identity: SwiftWin32.AffineTransform = .identity
    XCTAssertEqual(identity.a, 1.0)
    XCTAssertEqual(identity.b, 0.0)
    XCTAssertEqual(identity.c, 0.0)
    XCTAssertEqual(identity.d, 1.0)
    XCTAssertEqual(identity.tx, 0.0)
    XCTAssertEqual(identity.ty, 0.0)
  }

  func testAffineTransformIdentityIsIdentity() {
    let transform: SwiftWin32.AffineTransform =
        SwiftWin32.AffineTransform( a: 1.0,  b: 0.0,
                                    c: 0.0,  d: 1.0,
                                   tx: 0.0, ty: 0.0)

    XCTAssertTrue(SwiftWin32.AffineTransform.identity.isIdentity)
    XCTAssertTrue(transform.isIdentity)

    XCTAssertFalse(SwiftWin32.AffineTransform().isIdentity)
  }

  func testRectComputedProperties() {
    let r1: Rect = Rect(origin: .zero, size: Size(width: 32, height: 32))
    XCTAssertEqual(r1.midX, 16)
    XCTAssertEqual(r1.midY, 16)

    let r2: Rect = Rect(origin: Point(x: 4, y: 4),
                        size: Size(width: 16, height: 16))
    XCTAssertEqual(r2.midX, 12)
    XCTAssertEqual(r2.midY, 12)
  }

  static var allTests = [
    ("testAffineTransformIdentity", testAffineTransformIdentity),
    ("testAffineTransformIdentityIsIdentity", testAffineTransformIdentityIsIdentity)
  ]
}
