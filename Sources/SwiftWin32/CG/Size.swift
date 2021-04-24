// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

public struct Size {
  public static let zero: Size = Size(width: 0, height: 0)

  public var height: Double
  public var width: Double

  public init(width: Float, height: Float) {
    self.init(width: Double(width), height: Double(height))
  }

  public init(width: Double, height: Double) {
    self.height = height
    self.width = width
  }

  public init(width: Int, height: Int) {
    self.init(width: Double(width), height: Double(height))
  }

  func applying(_ transform: AffineTransform) -> Size {
    return Size(width: transform.a * self.width + transform.c * self.height,
                height: transform.b * self.width + transform.d * self.height)
  }
}

extension Size: Equatable {
}

extension Size: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Size(width: \(width), height: \(height))"
  }
}
