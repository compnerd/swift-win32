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
    let null: Rect = .null
    XCTAssertEqual(null.applying(AffineTransform(rotationAngle: .pi)),
                   Rect.null)

    let nonStandardized: Rect =
        Rect(origin: .zero, size: Size(width: -32, height: -32))
    XCTAssertEqual(nonStandardized.applying(.identity),
                   Rect(x: -32.0, y: -32.0, width: 32.0, height: 32.0))

    let nonStandardizedOblong: Rect =
        Rect(origin: Point(x: -16, y: -8), size: Size(width: -16, height: -8))
    XCTAssertEqual(nonStandardizedOblong.applying(AffineTransform(rotationAngle: .pi / 2)),
                   Rect(x: 7.999999999999998, y: -32, width: 8, height: 16))

    var rect: Rect =
        Rect(origin: Point(x: -6, y: -7),
             size: Size(width: 12, height: 14))
            .applying(AffineTransform(rotationAngle: Double.pi/2))

    XCTAssertEqual(rect.origin.x, -7)
    XCTAssertEqual(rect.origin.y, -6)
    XCTAssertEqual(rect.size.width, 14)
    XCTAssertEqual(rect.size.height, 12)


    rect =
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

  func testRectOffsetByNullRect() {
    XCTAssertTrue(Rect.null.offsetBy(dx: 1.0, dy: 1.0).isNull)
  }

  func testRectOffsetBy() {
    let r1: Rect = Rect.zero.offsetBy(dx: 4.0, dy: 4.0)
    XCTAssertEqual(r1.origin, Point(x: 4.0, y: 4.0))
    XCTAssertEqual(r1.size, .zero)

    let r2: Rect = Rect(origin: Point(x: 4.0, y: 4.0),
                        size: Size(width: 4.0, height: 4.0))
                       .offsetBy(dx: 4.0, dy: 4.0)
    XCTAssertEqual(r2.origin, Point(x: 8.0, y: 8.0))
    XCTAssertEqual(r2.size, Size(width: 4.0, height: 4.0))

    let nonStandardized: Rect =
        Rect(origin: .zero, size: Size(width: -32, height: -32))
    XCTAssertEqual(nonStandardized.offsetBy(dx: 16.0, dy: 16.0),
                   Rect(x: -16.0, y: -16.0, width: 32.0, height: 32.0))
  }

  func testRectStandardizing() {
    let null: Rect = .null
    XCTAssertEqual(null.standardized, Rect.null)

    let normal: Rect = Rect(x: 0, y: 0, width: 32, height: 32)
    XCTAssertEqual(normal.standardized, normal)

    let negativeHeight: Rect = Rect(x: 0, y: 0, width: -32, height: 32)
    XCTAssertEqual(negativeHeight.standardized,
                   Rect(x: -32, y: 0, width: 32, height: 32))

    let negativeWidth: Rect = Rect(x: 0, y: 0, width: 32, height: -32)
    XCTAssertEqual(negativeWidth.standardized,
                   Rect(x: 0, y: -32, width: 32, height: 32))

    let negativeHeightAndWidth: Rect = Rect(x: 0, y: 0, width: -32, height: -32)
    XCTAssertEqual(negativeHeightAndWidth.standardized,
                   Rect(x: -32, y: -32, width: 32, height: 32))

    let positiveOrigin: Rect = Rect(x: 32, y: 32, width: -32, height: -32)
    XCTAssertEqual(positiveOrigin.standardized,
                   Rect(origin: .zero, size: Size(width: 32, height: 32)))

    let negativeOrigin: Rect = Rect(x: -32, y: -32, width: -32, height: -32)
    XCTAssertEqual(negativeOrigin.standardized,
                   Rect(x: -64, y: -64, width: 32, height: 32))
  }

  func testRectIntegral() {
    let null: Rect = .null
    XCTAssertEqual(null.integral, Rect.null)
  }

  func testRectInsetBy() {
    let null: Rect = .null
    XCTAssertEqual(null.insetBy(dx: 0.0, dy: 0.0), Rect.null)

    let normal: Rect = Rect(x: 4.0, y: 4.0, width: 16.0, height: 8.0)
    XCTAssertEqual(normal.insetBy(dx: 2.0, dy: 2.0),
                   Rect(x: 6.0, y: 6.0, width: 12.0, height: 4.0))

    let nonStandardized: Rect =
        Rect(origin: .zero, size: Size(width: -32, height: -32))
    XCTAssertEqual(nonStandardized.insetBy(dx: 4.0, dy: 4.0),
                   Rect(x: -28.0, y: -28.0, width: 24.0, height: 24.0))
  }

  static var allTests = [
    ("testAffineTransformIdentity", testAffineTransformIdentity),
    ("testAffineTransformIdentityIsIdentity", testAffineTransformIdentityIsIdentity),
    ("testRectComputedProperties", testRectComputedProperties),
    ("testRectApplyAffineTransform", testRectApplyAffineTransform),
    ("testRectOffsetByNullRect", testRectOffsetByNullRect),
    ("testRectOffsetBy", testRectOffsetBy),
    ("testRectStandardizing", testRectStandardizing),
    ("testRectIntegral", testRectIntegral),
    ("testRectInsetBy", testRectInsetBy),
  ]
}
