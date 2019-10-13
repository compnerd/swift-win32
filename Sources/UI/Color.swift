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

public extension Color {
  static var blue: Color = Color(red: 0.0, green: 0.0, blue: 1.0)
  static var brown: Color = Color(red: 0.6, green: 0.4, blue: 0.2)
  static var cyan: Color = Color(red: 0.0, green: 1.0, blue: 1.0)
  static var green: Color = Color(red: 0.0, green: 1.0, blue: 0.0)
  static var magenta: Color = Color(red: 1.0, green: 0.0, blue: 1.0)
  static var orange: Color = Color(red: 1.0, green: 0.5, blue: 0.0)
  static var purple: Color = Color(red: 0.5, green: 0.0, blue: 0.5)
  static var red: Color = Color(red: 1.0, green: 0.0, blue: 0.0)
  static var yellow: Color = Color(red: 1.0, green: 1.0, blue: 0.0)
}
