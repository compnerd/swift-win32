// Copyright © 2021 Saleem Abulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import SwiftWin32
import XCTest

final class ColorTests: XCTestCase {
  func testGetColorComponentsRGBA() {
    let rgba: Color = Color(red: 0.1, green: 0.3, blue: 0.7, alpha: 1.0)
    let dyn: Color = Color(dynamicProvider: { _ in rgba })
    let hsba: Color =
        Color(hue: 0.61, saturation: 0.85, brightness: 0.70, alpha: 1.0)

    XCTAssertTrue(rgba.getRed(nil, green: nil, blue: nil, alpha: nil))

    var red: Double = 0.0, green: Double = 0.0, blue: Double = 0.0, alpha: Double = 0.0
    XCTAssertTrue(rgba.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
    XCTAssertEqual(red, 0.1)
    XCTAssertEqual(green, 0.3)
    XCTAssertEqual(blue, 0.7)
    XCTAssertEqual(alpha, 1.0)

    XCTAssertTrue(dyn.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
    XCTAssertEqual(red, 0.1)
    XCTAssertEqual(green, 0.3)
    XCTAssertEqual(blue, 0.7)
    XCTAssertEqual(alpha, 1.0)

    XCTAssertTrue(hsba.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
    XCTAssertEqual(red, 0.1, accuracy: 0.01)
    XCTAssertEqual(green, 0.3, accuracy: 0.01)
    XCTAssertEqual(blue, 0.7)
    XCTAssertEqual(alpha, 1.0)
  }

  func testGetColorComponentsHSBA() {
    let hsba: Color =
        Color(hue: 0.61, saturation: 0.85, brightness: 0.70, alpha: 1.0)
    let dyn: Color = Color(dynamicProvider: { _ in hsba })
    let rgba: Color = Color(red: 0.1, green: 0.3, blue: 0.7, alpha: 1.0)

    XCTAssertTrue(hsba.getHue(nil, saturation: nil, brightness: nil, alpha: nil))

    var hue: Double = 0.0, saturation: Double = 0.0, brightness: Double = 0.0, alpha: Double = 0.0
    XCTAssertTrue(hsba.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
    XCTAssertEqual(hue, 0.61)
    XCTAssertEqual(saturation, 0.85)
    XCTAssertEqual(brightness, 0.70)
    XCTAssertEqual(alpha, 1.0)

    XCTAssertTrue(dyn.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
    XCTAssertEqual(hue, 0.61)
    XCTAssertEqual(saturation, 0.85)
    XCTAssertEqual(brightness, 0.70)
    XCTAssertEqual(alpha, 1.0)

    XCTAssertTrue(rgba.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
    XCTAssertEqual(hue, 0.61, accuracy: 0.01)
    XCTAssertEqual(saturation, 0.85, accuracy: 0.01)
    XCTAssertEqual(brightness, 0.70)
    XCTAssertEqual(alpha, 1.0)
  }

  func testGetColorComponentsGrey() {
    let grey: Color = Color(white: 0.39, alpha: 1.0)
    let dyn: Color = Color(dynamicProvider: { _ in grey })
    let rgba: Color = Color(red: 0.1, green: 0.3, blue: 0.7, alpha: 1.0)
    let hsba: Color =
        Color(hue: 0.61, saturation: 0.85, brightness: 0.70, alpha: 1.0)

    XCTAssertTrue(grey.getWhite(nil, alpha: nil))

    var white: Double = 0.0, alpha: Double = 0.0
    XCTAssertTrue(grey.getWhite(&white, alpha: &alpha))
    XCTAssertEqual(white, 0.39)
    XCTAssertEqual(alpha, 1.0)

    XCTAssertTrue(dyn.getWhite(&white, alpha: &alpha))

    XCTAssertTrue(rgba.getWhite(&white, alpha: &alpha))
    XCTAssertEqual(white, 0.29, accuracy: 0.01)
    XCTAssertEqual(alpha, 1.0)

    XCTAssertTrue(hsba.getWhite(&white, alpha: &alpha))
    XCTAssertEqual(white, 0.29, accuracy: 0.01)
    XCTAssertEqual(alpha, 1.0)
  }

  static var allTests = [
    ("testGetColorComponentsRGBA", testGetColorComponentsRGBA),
    ("testGetColorComponentsHSBA", testGetColorComponentsHSBA),
    ("testGetColorComponentsGrey", testGetColorComponentsGrey),
  ]
}
