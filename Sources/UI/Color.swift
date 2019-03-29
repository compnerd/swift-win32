
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

