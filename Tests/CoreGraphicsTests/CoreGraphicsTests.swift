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

  func testRectApplyAffineTransform() {
    var rect: Rect =
        Rect(origin: Point(x: 45, y: 115),
             size: Size(width: 13, height: 14))
            .applying(AffineTransform(rotationAngle: 42))

    // Test data comes from the UIKit implementation, running on an iPhone,
    // and so deviation is expected.
    var accuracy = 1e-13
                     
    XCTAssertEqual(rect.origin.x, 82.20082974097352, accuracy: accuracy)
    XCTAssertEqual(rect.origin.y, -104.75635541260408, accuracy: accuracy)
    XCTAssertEqual(rect.size.width, 18.031110765667435, accuracy: accuracy)
    XCTAssertEqual(rect.size.height, 17.514574532740156, accuracy: accuracy)

    // Deviation increases with more operations
    accuracy = 1e-12

    rect =
        Rect(origin: Point(x: 45, y: 115),
             size: Size(width: 13, height: 14))
            .applying(AffineTransform(rotationAngle: -104))
            .applying(AffineTransform(translationX: -26, y: 22))
            .applying(AffineTransform(scaleX: 7, y: 5))

    XCTAssertEqual(rect.origin.x, -856.8534424207578, accuracy: accuracy)
    XCTAssertEqual(rect.origin.y, -428.36482622296273, accuracy: accuracy)
    XCTAssertEqual(rect.size.width, 117.68398448828839, accuracy: accuracy)
    XCTAssertEqual(rect.size.height, 87.18621695814943, accuracy: accuracy)

  }

  static var allTests = [
    ("testAffineTransformIdentity", testAffineTransformIdentity),
    ("testAffineTransformIdentityIsIdentity", testAffineTransformIdentityIsIdentity),
    ("testRectComputedProperties", testRectComputedProperties),
    ("testRectApplyAffineTransform", testRectApplyAffineTransform),
  ]
}
