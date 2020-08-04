/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

import WinSDK

public struct Color {
  internal let rawValue: DWORD

  /// Creating a Color from Component Values
  public init(red: Double, green: Double, blue: Double, alpha: Double) {
    self.rawValue = 0
                  | (DWORD(blue * 255.0) << 16)
                  | (DWORD(green * 255.0) << 8)
                  | (DWORD(red * 255.0) << 0)
  }

  public init(white: Double, alpha: Double) {
    self.rawValue = 0
                  | (DWORD(white * 255.0) << 16)
                  | (DWORD(white * 255.0) <<  8)
                  | (DWORD(white * 255.0) <<  0)
  }
}

extension Color {
  internal var COLORREF: COLORREF { return rawValue }
}

extension Color: _ExpressibleByColorLiteral {
  public init(_colorLiteralRed red: Float, green: Float, blue: Float,
              alpha: Float) {
    self.init(red: Double(red), green: Double(green), blue: Double(blue),
              alpha: Double(alpha))
  }
}

extension Color: Equatable {
}

public func ==(lhs: Color, rhs: Color) -> Bool {
  return lhs.rawValue == rhs.rawValue
}

/// Fixed Colors
public extension Color {
  static var black: Color = Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
  static var blue: Color = Color(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
  static var brown: Color = Color(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0)
  static var cyan: Color = Color(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
  static var darkGray: Color = Color(white: 1.0 / 3.0, alpha: 1.0)
  static var gray: Color = Color(white: 0.5, alpha: 1.0)
  static var green: Color = Color(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
  static var lightGray: Color = Color(white: 2.0 / 3.0, alpha: 1.0)
  static var magenta: Color = Color(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
  static var orange: Color = Color(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
  static var purple: Color = Color(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
  static var red: Color = Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
  static var white: Color = Color(white: 1.0, alpha: 1.0)
  static var yellow: Color = Color(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
}

extension Color {
  internal init(red: Int, green: Int, blue: Int,
                alpha: Int = 255) {
    self.init(red: Double(red) / 255.0, green: Double(green) / 255.0,
              blue: Double(blue) / 255.0, alpha: Double(alpha) / 255.0)
  }
}

/// Adaptable Colors
extension Color {
  public static var systemBlue: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 0, green: 122, blue: 255)
    case (.normal, .dark):
      return Color(red: 10, green: 132, blue: 255)
    case (.high, .light):
      return Color(red: 0, green: 64, blue: 221)
    case (.high, .dark):
      return Color(red: 64, green: 156, blue: 255)
    }
  }

  public static var systemGreen: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 52, green: 199, blue: 89)
    case (.normal, .dark):
      return Color(red: 48, green: 209, blue: 88)
    case (.high, .light):
      return Color(red: 36, green: 138, blue: 61)
    case (.high, .dark):
      return Color(red: 48, green: 219, blue: 91)
    }
  }

  public static var systemIndigo: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 88, green: 86, blue: 214)
    case (.normal, .dark):
      return Color(red: 94, green: 92, blue: 230)
    case (.high, .light):
      return Color(red: 54, green: 52, blue: 163)
    case (.high, .dark):
      return Color(red: 125, green: 122, blue: 255)
    }
  }

  public static var systemOrange: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 255, green: 149, blue: 0)
    case (.normal, .dark):
      return Color(red: 255, green: 159, blue: 10)
    case (.high, .light):
      return Color(red: 201, green: 52, blue: 0)
    case (.high, .dark):
      return Color(red: 255, green: 179, blue: 64)
    }
  }

  public static var systemPink: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 255, green: 45, blue: 85)
    case (.normal, .dark):
      return Color(red: 255, green: 55, blue: 95)
    case (.high, .light):
      return Color(red: 211, green: 15, blue: 69)
    case (.high, .dark):
      return Color(red: 255, green: 100, blue: 130)
    }
  }

  public static var systemPurple: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 175, green: 82, blue: 222)
    case (.normal, .dark):
      return Color(red: 191, green: 90, blue: 242)
    case (.high, .light):
      return Color(red: 137, green: 68, blue: 171)
    case (.high, .dark):
      return Color(red: 218, green: 143, blue: 255)
    }
  }

  public static var systemRed: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 255, green: 59, blue: 48)
    case (.normal, .dark):
      return Color(red: 255, green: 69, blue: 58)
    case (.high, .light):
      return Color(red: 215, green: 0, blue: 21)
    case (.high, .dark):
      return Color(red: 255, green: 105, blue: 97)
    }
  }

  public static var systemTeal: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 90, green: 200, blue: 250)
    case (.normal, .dark):
      return Color(red: 100, green: 210, blue: 255)
    case (.high, .light):
      return Color(red: 0, green: 113, blue: 164)
    case (.high, .dark):
      return Color(red: 112, green: 215, blue: 255)
    }
  }

  public static var systemYellow: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 255, green: 204, blue: 0)
    case (.normal, .dark):
      return Color(red: 255, green: 214, blue: 10)
    case (.high, .light):
      return Color(red: 178, green: 80, blue: 0)
    case (.high, .dark):
      return Color(red: 255, green: 212, blue: 38)
    }
  }
}

/// Adaptable Grey Colors
extension Color {
  public static var systemGray: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 142, green: 142, blue: 147)
    case (.normal, .dark):
      return Color(red: 142, green: 142, blue: 147)
    case (.high, .light):
      return Color(red: 108, green: 108, blue: 112)
    case (.high, .dark):
      return Color(red: 174, green: 174, blue: 178)
    }
  }

  public static var systemGray2: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 174, green: 174, blue: 178)
    case (.normal, .dark):
      return Color(red: 99, green: 99, blue: 102)
    case (.high, .light):
      return Color(red: 142, green: 142, blue: 147)
    case (.high, .dark):
      return Color(red: 124, green: 124, blue: 128)
    }
  }

  public static var systemGray3: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 199, green: 199, blue: 204)
    case (.normal, .dark):
      return Color(red: 72, green: 72, blue: 74)
    case (.high, .light):
      return Color(red: 174, green: 174, blue: 178)
    case (.high, .dark):
      return Color(red: 84, green: 84, blue: 86)
    }
  }

  public static var systemGray4: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 209, green: 209, blue: 214)
    case (.normal, .dark):
      return Color(red: 58, green: 58, blue: 60)
    case (.high, .light):
      return Color(red: 188, green: 188, blue: 192)
    case (.high, .dark):
      return Color(red: 68, green: 68, blue: 70)
    }
  }

  public static var systemGray5: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 229, green: 229, blue: 234)
    case (.normal, .dark):
      return Color(red: 44, green: 44, blue: 46)
    case (.high, .light):
      return Color(red: 216, green: 216, blue: 220)
    case (.high, .dark):
      return Color(red: 54, green: 54, blue: 56)
    }
  }

  public static var systemGray6: Color {
    let traits: TraitCollection = TraitCollection.current
    switch (traits.accessibilityContrast, traits.userInterfaceStyle) {
    case (.unspecified, _), (_, .unspecified):
      log.warning("unable to query contrast or color scheme")
      fallthrough
    case (.normal, .light):
      return Color(red: 242, green: 242, blue: 247)
    case (.normal, .dark):
      return Color(red: 28, green: 28, blue: 30)
    case (.high, .light):
      return Color(red: 235, green: 235, blue: 240)
    case (.high, .dark):
      return Color(red: 36, green: 36, blue: 38)
    }
  }
}
