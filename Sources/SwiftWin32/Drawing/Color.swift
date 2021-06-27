// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

extension Color {
  fileprivate enum Representation {
    case rgba(Double, Double, Double, Double)
    case hsba(Double, Double, Double, Double)
    case gray(Double, Double)
    case `func`((TraitCollection) -> Color)
  }
}

extension Color.Representation: Equatable {
  internal static func ==(_ lhs: Color.Representation,
                          _ rhs: Color.Representation) -> Bool {
    switch (lhs, rhs) {
    case let (.rgba(lr, lg, lb, la), .rgba(rr, rg, rb, ra)):
      return (lr, lg, lb, la) == (rr, rg, rb, ra)
    case let (.hsba(lh, ls, lb, la), .hsba(rh, rs, rb, ra)):
      return (lh, ls, lb, la) == (rh, rs, rb, ra)
    case let (.gray(lg, la), gray(rg, ra)):
      return (lg, la) == (rg, ra)
    case let (.func(lhs), .func(rhs)):
      return withUnsafePointer(to: lhs) { lhs in
        return withUnsafePointer(to: rhs) { rhs in
          lhs == rhs
        }
      }
    default: return false
    }
  }
}

extension Color.Representation: Hashable {
  public func hash(into hasher: inout Hasher) {
    switch self {
    case .rgba(let r, let g, let b, let a):
      hasher.combine(0) // colorspace
      hasher.combine(r)
      hasher.combine(g)
      hasher.combine(b)
      hasher.combine(a)
    case .hsba(let h, let s, let b, let a):
      hasher.combine(1) // colorspace
      hasher.combine(h)
      hasher.combine(s)
      hasher.combine(b)
      hasher.combine(a)
    case .gray(let white, let alpha):
      hasher.combine(2) // colorspace
      hasher.combine(white)
      hasher.combine(alpha)
    case .func(let body):
      withUnsafePointer(to: body) {
        hasher.combine($0)
      }
    }
  }
}

public struct Color {
  private let value: Representation

  // MARK - Creating a Color from Component Values

  /// Creates a color object using the specified opacity and grayscale values.
  public init(white: Double, alpha: Double) {
    self.value = .gray(white, alpha)
  }

  /// Creates a color object using the specified opacity and HSB color space
  /// component values.
  public init(hue: Double, saturation: Double, brightness: Double,
              alpha: Double) {
    self.value = .hsba(hue, saturation, brightness, alpha)
  }

  /// Creates a color object using the specified opacity and RGB component
  /// values.
  public init(red: Double, green: Double, blue: Double, alpha: Double) {
    self.value = .rgba(red, green, blue, alpha)
  }

  // MARK - Creating a Color Dynamically

  /// Creates a color object that uses the specified block to generate its color
  /// data dynamically.
  public init(dynamicProvider block: @escaping (TraitCollection) -> Color) {
    self.value = .func(block)
  }
}

extension COLORREF {
  fileprivate init(red r: Double, green g: Double, blue b: Double) {
    self = 0
         | (DWORD((b * 255.0).rounded(.toNearestOrAwayFromZero)) << 16)
         | (DWORD((g * 255.0).rounded(.toNearestOrAwayFromZero)) <<  8)
         | (DWORD((r * 255.0).rounded(.toNearestOrAwayFromZero)) <<  0)
  }
}

extension Color {
  internal var COLORREF: COLORREF {
    switch self.value {
    case .rgba(let r, let g, let b, _):
      return WinSDK.COLORREF(red: r, green: g, blue: b)
    case .hsba(let h, let s, let b, _):
      func f(_ n: Double) -> Double {
        let k = ucrt.fmod(n + (6.0 * h), 6.0)
        return b - b * s * max(0, min(k, 4 - k, 1))
      }

      return WinSDK.COLORREF(red: f(5.0), green: f(3.0), blue: f(1.0))
    case .gray(let w, _):
      return WinSDK.COLORREF(red: w * 255.0, green: w * 255.0, blue: w * 255.0)
    case .func(let body):
      return body(TraitCollection.current).COLORREF
    }
  }
}

extension Color: _ExpressibleByColorLiteral {
  public init(_colorLiteralRed red: Float, green: Float, blue: Float,
              alpha: Float) {
    self.init(red: Double(red), green: Double(green), blue: Double(blue),
              alpha: Double(alpha))
  }
}

extension Color: Equatable {
  public static func ==(lhs: Color, rhs: Color) -> Bool {
    // TODO(compnerd) make this more accurate
    return lhs.COLORREF == rhs.COLORREF
  }
}

extension Color: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.value)
  }
}

extension Color {
  internal init(color: COLORREF) {
    self.init(red: Int(GetRValue(color)), green: Int(GetGValue(color)),
              blue: Int(GetBValue(color)))
  }
}

extension Color {
  internal init(red: Int, green: Int, blue: Int,
                alpha: Double = 1.0) {
    self.init(red: Double(red) / 255.0, green: Double(green) / 255.0,
              blue: Double(blue) / 255.0, alpha: Double(alpha))
  }
}

// MARK - Standard Colors
extension Color {
  // MARK - Adaptable Colors

  /// A blue color that automatically adapts to the current trait environment.
  public static var systemBlue: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A brown color that automatically adapts to the current trait environment.
  public static var systemBrown: Color {
    fatalError("\(#function) not yet implemented")
  }

  /// A green color that automatically adapts to the current trait environment.
  public static var systemGreen: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// An indigo color that automatically adapts to the current trait
  /// environment.
  public static var systemIndigo: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// An orange color that automatically adapts to the current trait
  /// environment.
  public static var systemOrange: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A pink color that automatically adapts to the current trait environment.
  public static var systemPink: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A purple color that automatically adapts to the current trait environment.
  public static var systemPurple: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A red color that automatically adapts to the current trait environment.
  public static var systemRed: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A teal color that automatically adapts to the current trait environment.
  public static var systemTeal: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A yellow color that automatically adapts to the current trait environment.
  public static var systemYellow: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  // MARK - Adaptable Grey Colors

  /// The standard base gray color that adapts to the environment.
  public static var systemGray: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A second-level shade of grey that adapts to the environment.
  public static var systemGray2: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A third-level shade of grey that adapts to the environment.
  public static var systemGray3: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A fourth-level shade of grey that adapts to the environment.
  public static var systemGray4: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A fifth-level shade of grey that adapts to the environment.
  public static var systemGray5: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  /// A sixth-level shade of grey that adapts to the environment.
  public static var systemGray6: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
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
    })
  }

  // MARK - Transparent Color

  /// A color object with grayscale and alpha values that are both 0.0.
  public static var clear: Color {
    Color(white: 0.0, alpha: 0.0)
  }

  // MARK - Fixed Colors

  /// A color object in the sRGB color space with a grayscale value of 0.0 and
  /// an alpha value of 1.0.
  public static var black: Color {
    Color(white: 0.0, alpha: 1.0)
  }

  /// A color object with RGB values of 0.0, 0.0, and 1.0, and an alpha value of
  /// 1.0.
  public static var blue: Color {
    Color(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
  }

  /// A color object with RGB values of 0.6, 0.4, and 0.2, and an alpha value of
  /// 1.0.
  public static var brown: Color {
    Color(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0)
  }

  /// A color object with RGB values of 0.0, 1.0, and 1.0, and an alpha value of
  /// 1.0.
  public static var cyan: Color {
    Color(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
  }

  /// A color object with a grayscale value of 1/3 and an alpha value of 1.0.
  public static var darkGray: Color {
    Color(white: 1.0 / 3.0, alpha: 1.0)
  }

  /// A color object with a grayscale value of 0.5 and an alpha value of 1.0.
  public static var gray: Color {
    Color(white: 0.5, alpha: 1.0)
  }

  /// A color object with RGB values of 0.0, 1.0, and 0.0, and an alpha value of
  /// 1.0.
  public static var green: Color {
    Color(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
  }

  /// A color object with a grayscale value of 2/3 and an alpha value of 1.0.
  public static var lightGray: Color {
    Color(white: 2.0 / 3.0, alpha: 1.0)
  }

  /// A color object with RGB values of 1.0, 0.0, and 1.0, and an alpha value of
  /// 1.0.
  public static var magenta: Color {
    Color(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
  }

  /// A color object with RGB values of 1.0, 0.5, and 0.0, and an alpha value of
  /// 1.0.
  public static var orange: Color {
    Color(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
  }

  /// A color object with RGB values of 0.5, 0.0, and 0.5, and an alpha value of
  /// 1.0.
  public static var purple: Color {
    Color(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
  }

  /// A color object with RGB values of 1.0, 0.0, and 0.0, and an alpha value of
  /// 1.0.
  public static var red: Color {
    Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
  }

  /// A color object with a grayscale value of 1.0 and an alpha value of 1.0.
  public static var white: Color {
    Color(white: 1.0, alpha: 1.0)
  }

  /// A color object with RGB values of 1.0, 1.0, and 0.0, and an alpha value of
  /// 1.0.
  public static var yellow: Color {
    Color(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
  }
}

// MARK - UI Element Colors

extension Color {
  // MARK - Label Colors

  /// The Color for text labels that contain primary content.
  public static var label: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (_, .light):
        return Color(white: 0.0, alpha: 1.0)
      case (_, .dark):
        return Color(white: 1.0, alpha: 1.0)
      }
    })
  }

  /// The color for text labels that contain secondary content.
  public static var secondaryLabel: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 60, green: 60, blue: 67, alpha: 0.60)
      case (.high, .light):
        return Color(red: 60, green: 60, blue: 67, alpha: 0.68)
      case (.normal, .dark):
        return Color(red: 235, green: 235, blue: 245, alpha: 0.60)
      case (.high, .dark):
        return Color(red: 235, green: 235, blue: 245, alpha: 0.68)
      }
    })
  }

  /// The color for text labels that contain tertiary content.
  public static var tertiaryLabel: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 60.0, green: 60, blue: 67, alpha: 0.30)
      case (.high, .light):
        return Color(red: 60.0, green: 60, blue: 67, alpha: 0.38)
      case (.normal, .dark):
        return Color(red: 235, green: 235, blue: 245, alpha: 0.30)
      case (.high, .dark):
        return Color(red: 235, green: 235, blue: 245, alpha: 0.38)
      }
    })
  }

  /// The color for text labels that contain quatenary content.
  public static var quatenaryLabel: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 60, green: 60, blue: 67, alpha: 0.18)
      case (.high, .light):
        return Color(red: 60, green: 60, blue: 67, alpha: 0.26)
      case (.normal, .dark):
        return Color(red: 235, green: 235, blue: 245, alpha: 0.18)
      case (.high, .dark):
        return Color(red: 235, green: 235, blue: 245, alpha: 0.26)
      }
    })
  }

  // MARK - Fill Colors

  /// An overlay fill color for thin and small shapes.
  public static var systemFill: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 120, green: 120, blue: 128, alpha: 0.20)
      case (.high, .light):
        return Color(red: 120, green: 120, blue: 128, alpha: 0.28)
      case (.normal, .dark):
        return Color(red: 120, green: 120, blue: 128, alpha: 0.36)
      case (.high, .dark):
        return Color(red: 120, green: 120, blue: 128, alpha: 0.44)
      }
    })
  }

  /// An overlay fill color for medium-size shapes.
  public static var secondarySystemFill: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 120, green: 120, blue: 128, alpha: 0.16)
      case (.high, .light):
        return Color(red: 120, green: 120, blue: 128, alpha: 0.24)
      case (.normal, .dark):
        return Color(red: 120, green: 120, blue: 128, alpha: 0.32)
      case (.high, .dark):
        return Color(red: 120, green: 120, blue: 128, alpha: 0.40)
      }
    })
  }

  /// An overlay fill color for large shapes.
  public static var tertiarySystemFill: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 118, green: 118, blue: 128, alpha: 0.12)
      case (.high, .light):
        return Color(red: 118, green: 118, blue: 128, alpha: 0.20)
      case (.normal, .dark):
        return Color(red: 118, green: 118, blue: 128, alpha: 0.24)
      case (.high, .dark):
        return Color(red: 118, green: 118, blue: 128, alpha: 0.32)
      }
    })
  }

  /// An overlay fill color for large areas that contain complex content.
  public static var quaternarySystemFill: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 116, green: 116, blue: 128, alpha: 0.08)
      case (.high, .light):
        return Color(red: 116, green: 116, blue: 128, alpha: 0.16)
      case (.normal, .dark):
        return Color(red: 118, green: 118, blue: 128, alpha: 0.18)
      case (.high, .dark):
        return Color(red: 118, green: 118, blue: 128, alpha: 0.26)
      }
    })
  }

  // MARK - Text Colors

  /// The color for placeholder text in controls or text views.
  public static var placeholderText: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 60, green: 60, blue: 67, alpha: 0.30)
      case (.high, .light):
        return Color(red: 60, green: 60, blue: 67, alpha: 0.38)
      case (.normal, .dark):
        return Color(red: 235, green: 235, blue: 245, alpha: 0.30)
      case (.high, .dark):
        return Color(red: 235, green: 235, blue: 245, alpha: 0.38)
      }
    })
  }

  /// Standard Content Background Colors
  ///
  /// Use these colors for standard table views and designs that have a white
  /// primary background in a light environment.

  /// The color for the main background of your interface.
  public static var systemBackground: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(white: 1.0, alpha: 1.0)
      case (.high, .light):
        return Color(white: 1.0, alpha: 1.0)
      case (.normal, .dark):
        return Color(white: 0.0, alpha: 1.0)
      case (.high, .dark):
        return Color(white: 0.0, alpha: 1.0)
      }
    })
  }

  /// The color for content layered on top of the main background.
  public static var secondarySystemBackground: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 242, green: 242, blue: 247, alpha: 1.0)
      case (.high, .light):
        return Color(red: 235, green: 235, blue: 240, alpha: 1.0)
      case (.normal, .dark):
        return Color(red: 28, green: 28, blue: 30, alpha: 1.0)
      case (.high, .dark):
        return Color(red: 36, green: 36, blue: 38, alpha: 1.0)
      }
    })
  }

  /// The color for content layered on top of secondary backgrounds.
  public static var tertiarySystemBackground: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(white: 1.0, alpha: 1.0)
      case (.high, .light):
        return Color(white: 1.0, alpha: 1.0)
      case (.normal, .dark):
        return Color(red: 44, green: 44, blue: 46, alpha: 1.0)
      case (.high, .dark):
        return Color(red: 54, green: 54, blue: 56, alpha: 1.0)
      }
    })
  }

  /// Grouped Content Background Colors
  ///
  /// Use these colors for grouped content, including table views and
  /// platter-based designs.

  /// The color for the main background of your grouped interface.
  public static var systemGroupedBackground: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 242, green: 242, blue: 247, alpha: 1.0)
      case (.high, .light):
        return Color(red: 235, green: 235, blue: 240, alpha: 1.0)
      case (.normal, .dark):
        return Color(white: 0.0, alpha: 1.0)
      case (.high, .dark):
        return Color(white: 0.0, alpha: 1.0)
      }
    })
  }

  /// The color for content layered on top of the main background of your
  /// grouped interface.
  public static var secondarySystemGroupedBackground: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 242, green: 242, blue: 247, alpha: 1.0)
      case (.high, .light):
        return Color(white: 1.0, alpha: 1.0)
      case (.normal, .dark):
        return Color(red: 28, green: 28, blue: 30, alpha: 1.0)
      case (.high, .dark):
        return Color(red: 36, green: 36, blue: 38, alpha: 1.0)
      }
    })
  }

  /// The color for content layered on top of secondary backgrounds of your
  /// grouped interface.
  public static var tertiarySystemGroupedBackground: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 242, green: 242, blue: 247, alpha: 1.0)
      case (.high, .light):
        return Color(red: 235, green: 235, blue: 240, alpha: 1.0)
      case (.normal, .dark):
        return Color(red: 44, green: 44, blue: 46, alpha: 1.0)
      case (.high, .dark):
        return Color(red: 54, green: 54, blue: 56, alpha: 1.0)
      }
    })
  }

  // MARK - Separator Colors

  /// The color for thin borders or divider lines that allows some underlying
  /// content to be visible.
  public static var separator: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 60, green: 60, blue: 67, alpha: 0.29)
      case (.high, .light):
        return Color(red: 60, green: 60, blue: 67, alpha: 0.37)
      case (.normal, .dark):
        return Color(red: 84, green: 84, blue: 88, alpha: 0.60)
      case (.high, .dark):
        return Color(red: 84, green: 84, blue: 88, alpha: 0.70)
      }
    })
  }

  /// The color for borders or divider lines that hides any underlying content.
  public static var opaqueSeparator: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 198, green: 198, blue: 200, alpha: 1.0)
      case (.high, .light):
        return Color(red: 198, green: 198, blue: 200, alpha: 1.0)
      case (.normal, .dark):
        return Color(red: 56, green: 56, blue: 58, alpha: 1.0)
      case (.high, .dark):
        return Color(red: 56, green: 56, blue: 58, alpha: 1.0)
      }
    })
  }

  // MARK - Link Color

  /// The color for links.
  public static var link: Color {
    Color(dynamicProvider: {
      switch ($0.accessibilityContrast, $0.userInterfaceStyle) {
      case (.unspecified, _), (_, .unspecified):
        log.warning("unable to query contrast or color scheme")
        fallthrough
      case (.normal, .light):
        return Color(red: 0, green: 122, blue: 255, alpha: 1.0)
      case (.high, .light):
        return Color(red: 0, green: 122, blue: 255, alpha: 1.0)
      case (.normal, .dark):
        return Color(red: 9, green: 132, blue: 255, alpha: 1.0)
      case (.high, .dark):
        return Color(red: 9, green: 132, blue: 255, alpha: 1.0)
      }
    })
  }

  // MARK - Nonadaptable Colors

  /// The nonadaptable system color for text on a light background.
  public static var darkText: Color {
    return Color(white: 0.0, alpha: 1.0)
  }

  /// The nonadaptable system color for text on a dark background.
  public static var lightText: Color {
    return Color(white: 1.0, alpha: 0.6)
  }
}
