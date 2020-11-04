/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public struct Point {
  public static let zero: Point = Point(x: 0, y: 0)

  public var x: Double
  public var y: Double

  public init(x: Float, y: Float) {
    self.init(x: Double(x), y: Double(y))
  }

  public init(x: Double, y: Double) {
    self.x = x
    self.y = y
  }

  public init(x: Int, y: Int) {
    self.init(x: Double(x), y: Double(y))
  }

  public func applying(_ transform: AffineTransform) -> Point {
    return Point(x: transform.a * self.x + transform.c * self.y + transform.tx,
                 y: transform.b * self.x + transform.d * self.y + transform.ty)
  }
}

extension Point: Equatable {
}

extension Point: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Point(x: \(x), y: \(y))"
  }
}
