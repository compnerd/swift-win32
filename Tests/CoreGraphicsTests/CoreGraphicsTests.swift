// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest

import SwiftWin32

private typealias AffineTransform = SwiftWin32.AffineTransform

final class CoreGraphicsTests: XCTestCase {
  func testAffineTransformIdentity() {
    let identity: AffineTransform = .identity
    XCTAssertEqual(identity.a, 1.0)
    XCTAssertEqual(identity.b, 0.0)
    XCTAssertEqual(identity.c, 0.0)
    XCTAssertEqual(identity.d, 1.0)
    XCTAssertEqual(identity.tx, 0.0)
    XCTAssertEqual(identity.ty, 0.0)
  }

  func testAffineTransformIdentityIsIdentity() {
    let transform: AffineTransform = AffineTransform( a: 1.0,  b: 0.0,
                                                      c: 0.0,  d: 1.0,
                                                     tx: 0.0, ty: 0.0)
    XCTAssertTrue(transform.isIdentity)

    XCTAssertTrue(AffineTransform.identity.isIdentity)
  }

  func testAffineTransformDefaultConstructor() {
    XCTAssertFalse(AffineTransform().isIdentity)
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

    var rect: Rect

    rect = Rect(origin: Point(x: -6, y: -7),
                size: Size(width: 12, height: 14))
              .applying(AffineTransform(rotationAngle: .pi / 2))
    XCTAssertEqual(rect, Rect(x: -7, y: -6, width: 14, height: 12))

    rect = Rect(origin: Point(x: 45, y: 115),
                size: Size(width: 13, height: 14))
              .applying(AffineTransform(rotationAngle: 42))
    XCTAssertEqual(rect.origin.x, 82.20082974097352,
                   accuracy: .ulpOfOne.squareRoot())
    XCTAssertEqual(rect.origin.y, -104.75635541260408,
                   accuracy: .ulpOfOne.squareRoot())
    XCTAssertEqual(rect.size.width, 18.031110765667435,
                   accuracy: .ulpOfOne.squareRoot())
    XCTAssertEqual(rect.size.height, 17.514574532740156,
                   accuracy: .ulpOfOne.squareRoot())

    rect = Rect(origin: Point(x: 45, y: 115),
                size: Size(width: 13, height: 14))
              .applying(AffineTransform(rotationAngle: -104))
              .applying(AffineTransform(translationX: -26, y: 22))
              .applying(AffineTransform(scaleX: 7, y: 5))
    XCTAssertEqual(rect.origin.x, -856.8534424207578,
                   accuracy: .ulpOfOne.squareRoot())
    XCTAssertEqual(rect.origin.y, -428.36482622296273,
                   accuracy: .ulpOfOne.squareRoot())
    XCTAssertEqual(rect.size.width, 117.68398448828839,
                   accuracy: .ulpOfOne.squareRoot())
    XCTAssertEqual(rect.size.height, 87.18621695814943,
                   accuracy: .ulpOfOne.squareRoot())
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

  func testRectIntersection() {
    let r1: Rect = Rect(x: 0, y: 0, width: 100, height: 100)
    let r2: Rect = Rect(x: 25, y: 25, width: 50, height: 50)
    let r3: Rect = Rect(x: 75, y: 75, width: 50, height: 50)
    let r4: Rect = Rect(x: 125, y: 125, width: 50, height: 50)
    let r5: Rect = Rect(x: 75, y: 75, width: -50, height: -50)

    // concentric overlap
    XCTAssertEqual(r1.intersection(r2),
                   Rect(x: 25, y: 25, width: 50, height: 50))

    // communitivity
    XCTAssertEqual(r1.intersection(r2), r2.intersection(r1))

    // partial overlap
    XCTAssertEqual(r1.intersection(r3),
                   Rect(x: 75, y: 75, width: 25, height: 25))

    // no overlap
    XCTAssertTrue(r1.intersection(r4).isNull)

    // non-standard
    XCTAssertEqual(r5.intersection(r1),
                   Rect(x: 25, y: 25, width: 50, height: 50))
    XCTAssertEqual(r1.intersection(r5),
                   Rect(x: 25, y: 25, width: 50, height: 50))
  }

  func testRectIntersects() {
    let r1: Rect = Rect(x: 0, y: 0, width: 100, height: 100)
    let r2: Rect = Rect(x: 25, y: 25, width: 50, height: 50)
    let r3: Rect = Rect(x: 75, y: 75, width: 50, height: 50)
    let r4: Rect = Rect(x: 125, y: 125, width: 50, height: 50)

    XCTAssertTrue(r1.intersects(r2))
    XCTAssertTrue(r2.intersects(r1))

    XCTAssertTrue(r1.intersects(r3))
    XCTAssertTrue(r3.intersects(r1))

    XCTAssertFalse(r1.intersects(r4))
    XCTAssertFalse(r4.intersects(r1))
  }

  func testRectNonstandardEquality() {
    let r1: Rect = Rect(x: 0, y: 0, width: 10, height: 10)
    let r2: Rect = Rect(x: 10, y: 10, width: -10, height: -10)
    let r3: Rect = Rect(x: 10, y: 10, width: -9.9, height: -10)

    XCTAssertTrue(r1 == r2)
    XCTAssertFalse(r2 == r3)

    let null1: Rect = Rect.null
    let null2: Rect = Rect.null
    XCTAssertTrue(null1 == null2)
  }

  static var allTests = [
    ("testAffineTransformIdentity", testAffineTransformIdentity),
    ("testAffineTransformIdentityIsIdentity", testAffineTransformIdentityIsIdentity),
    ("testAffineTransformDefaultConstructor", testAffineTransformDefaultConstructor),
    ("testRectComputedProperties", testRectComputedProperties),
    ("testRectApplyAffineTransform", testRectApplyAffineTransform),
    ("testRectOffsetByNullRect", testRectOffsetByNullRect),
    ("testRectOffsetBy", testRectOffsetBy),
    ("testRectStandardizing", testRectStandardizing),
    ("testRectIntegral", testRectIntegral),
    ("testRectInsetBy", testRectInsetBy),
    ("testRectIntersection", testRectIntersection),
    ("testRectIntersects", testRectIntersects),
    ("testRectNonstandardEquality", testRectNonstandardEquality),
  ]
}
