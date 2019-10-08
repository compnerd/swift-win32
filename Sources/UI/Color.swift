
import WinSDK

public struct Color: _ExpressibleByColorLiteral {
  internal let rawValue: DWORD

  public var COLORREF: COLORREF { return rawValue }

  public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
    self.rawValue = 0
                  | (DWORD(blue * 255.0) << 16)
                  | (DWORD(green * 255.0) << 8)
                  | (DWORD(red * 255.0) << 0)
  }

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

extension Color {
  static class var blue: Color = Color(red: 0.0, green: 0.0, blue: 1.0)
  static class var brown: Color = Color(red: 0.6, green: 0.4, blue: 0.2)
  static class var cyan: Color = Color(red: 0.0, green: 1.0, blue: 1.0)
  static class var green: Color = Color(red: 0.0, green: 1.0, blue: 0.0)
  static class var magenta: Color = Color(red: 1.0, green: 0.0, blue: 1.0)
  static class var orange: Color = Color(red: 1.0, green: 0.5, blue: 0.0)
  static class var purple: Color = Color(red: 0.5, green: 0.0, blue: 0.5)
  static class var red: Color = Color(red: 1.0, green: 0.0, blue: 0.0)
  static class var yellow: Color = Color(red: 1.0, green: 1.0, blue: 0.0)
}

