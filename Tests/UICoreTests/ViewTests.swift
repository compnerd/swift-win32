// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import SwiftWin32

final class ViewTests: XCTestCase {
  func testConvertSameParent() {
    let window = View(frame: Rect(x: 0.0, y: 0.0, width: 1000, height: 1000))

    let textfield: View =
        View(frame: Rect(x: 4.0, y: 92.0, width: 254.0, height: 17.0))

    let password: View =
        View(frame: Rect(x: 4.0, y: 113.0, width: 254.0, height: 17.0))
     
    window.addSubview(password)
    window.addSubview(textfield)

    let boundsRect = Rect(x: 0, y: 0, width: 254.0, height: 17.0)

    let convertRect = textfield.convert(boundsRect, to: password)

    let convertPoint = textfield.convert(textfield.bounds.origin, to: password)

    XCTAssertEqual(convertRect, Rect(x: 0.0, y: -21.0, width: 254.0, height: 17.0))
    XCTAssertEqual(convertPoint, Point(x: 0.0, y: -21.0))
  }

  func testConvertWithRotationsAndBounds() {
    let root = View(frame: Rect(x: 0.0, y: 0.0, width: 1000, height: 1000))

    let childA = View(frame: Rect(x: 4.0, y: 92.0, width: 254.0, height: 17.0))
    childA.transform = AffineTransform(rotationAngle: 110)
    childA.bounds = Rect(x: 144.0, y: 23.0, width: 20, height: 15)

    let childB = View(frame: Rect(x: 12.0, y: 150.0, width: 400.0, height: 400.0))
    childB.transform = AffineTransform(rotationAngle: -30)

    let grandChild = View(frame: Rect(x: 40.0, y: 113.0, width: 10, height: 10))
    grandChild.transform = AffineTransform(rotationAngle: 42)
    grandChild.bounds = Rect(x: 4.0, y: 3.0, width: 20, height: 15)

    root.addSubview(childA)
    root.addSubview(childB)

    childB.addSubview(grandChild)

    // Test data comes from the UIKit implementation, running on an iPhone,
    // and so deviation is expected.
    let accuracy = 0.00000000001

    let inputPoint = Point(x: 45, y: 115)

    var point = grandChild.convert(inputPoint, to: childA)
    XCTAssertEqual(point.x, -72.9941233911901, accuracy: accuracy)
    XCTAssertEqual(point.y, -114.85495931677, accuracy: accuracy)

    point = grandChild.convert(inputPoint, from: childA)
    XCTAssertEqual(point.x, 80.12346855145998, accuracy: accuracy)
    XCTAssertEqual(point.y, -140.97315764408575, accuracy: accuracy)

    
    let inputRect = Rect(origin: Point(x: 45, y: 115), size: Size(width: 13, height: 14))
    var rect = grandChild.convert(inputRect, to: childB)
    XCTAssertEqual(rect.origin.x, 123.17714789769627, accuracy: accuracy)
    XCTAssertEqual(rect.origin.y, 30.274792065592464, accuracy: accuracy)
    XCTAssertEqual(rect.size.width, 18.031110765667435, accuracy: accuracy)
    XCTAssertEqual(rect.size.height, 17.514574532740156, accuracy: accuracy)

    rect = grandChild.convert(inputRect, to: childA)
    XCTAssertEqual(rect.origin.x, -91.9808292852884, accuracy: accuracy)
    XCTAssertEqual(rect.origin.y, -126.65734667117412, accuracy: accuracy)
    XCTAssertEqual(rect.size.width, 19.295318391541684, accuracy: accuracy)
    XCTAssertEqual(rect.size.height, 19.58870361060326, accuracy: accuracy)

    rect = grandChild.convert(inputRect, from: childA)
    XCTAssertEqual(rect.origin.x, 69.16410886522763, accuracy: accuracy)
    XCTAssertEqual(rect.origin.y, -160.22950933436533, accuracy: accuracy)
    XCTAssertEqual(rect.size.width, 19.295318391541684, accuracy: accuracy)
    XCTAssertEqual(rect.size.height, 19.58870361060326, accuracy: accuracy)
  }

  func testConvertWithAllTransformsAndBounds() {
    let root = View(frame: Rect(x: 0.0, y: 0.0, width: 1000, height: 1000))
    let childA = View(frame: Rect(x: 4.0, y: 92.0, width: 254.0, height: 17.0))
    childA.transform = AffineTransform(translationX: 68, y: 419)
    childA.bounds = Rect(x: 144.0, y: 23.0, width: 20, height: 15)

    let childB = View(frame: Rect(x: 12.0, y: 150.0, width: 400.0, height: 400.0))
    childB.transform = AffineTransform(scaleX: 7, y: 18)

    let grandChild = View(frame: Rect(x: 40.0, y: 113.0, width: 10, height: 10))
    grandChild.transform = AffineTransform(rotationAngle: 42)
    grandChild.bounds = Rect(x: 4.0, y: 3.0, width: 20, height: 15)

    root.addSubview(childA)
    root.addSubview(childB)

    childB.addSubview(grandChild)

    // Test data comes from the UIKit implementation, running on an iPhone,
    // and so deviation is expected.
    let accuracy = 0.00000000001

    let inputPoint = Point(x: 45, y: 115)

    var point = grandChild.convert(inputPoint, to: childA)
    XCTAssertEqual(point.x, -334.36130105218615, accuracy: accuracy)
    XCTAssertEqual(point.y, -2878.791401230013, accuracy: accuracy)

    point = grandChild.convert(inputPoint, from: childA)
    XCTAssertEqual(point.x, -129.11445551798738, accuracy: accuracy)
    XCTAssertEqual(point.y, 98.14414561159256, accuracy: accuracy)
    
    let inputRect = Rect(origin: Point(x: 45, y: 115), size: Size(width: 13, height: 14))
    var rect = grandChild.convert(inputRect, to: childB)
    XCTAssertEqual(rect.origin.x, 123.17714789769627, accuracy: accuracy)
    XCTAssertEqual(rect.origin.y, 30.274792065592464, accuracy: accuracy)
    XCTAssertEqual(rect.size.width, 18.031110765667435, accuracy: accuracy)
    XCTAssertEqual(rect.size.height, 17.514574532740156, accuracy: accuracy)

    rect = grandChild.convert(inputRect, to: childA)
    XCTAssertEqual(rect.origin.x, -370.7599647161262, accuracy: accuracy)
    XCTAssertEqual(rect.origin.y, -3194.0537428193356, accuracy: accuracy)
    XCTAssertEqual(rect.size.width, 126.21777535967215, accuracy: accuracy)
    XCTAssertEqual(rect.size.height, 315.26234158932266, accuracy: accuracy)

    rect = grandChild.convert(inputRect, from: childA)
    XCTAssertEqual(rect.origin.x, -130.5701354815033, accuracy: accuracy)
    XCTAssertEqual(rect.origin.y, 97.83304592215717, accuracy: accuracy)
    XCTAssertEqual(rect.size.width, 1.4556799635159337, accuracy: accuracy)
    XCTAssertEqual(rect.size.height, 2.0132111355644327, accuracy: accuracy)
  }

  static var allTests = [
    ("testConvertSameParent", testConvertSameParent),
    ("testConvertWithRotationsAndBounds", testConvertWithRotationsAndBounds),
    ("testConvertWithAllTransformsAndBounds", testConvertWithAllTransformsAndBounds),
  ]
}
