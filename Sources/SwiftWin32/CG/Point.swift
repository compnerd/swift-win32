// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A structure that contains a point in a two-dimensional coordinate system.
public struct Point {
  // MARK - Creating Point Values

  /// Creates a point with coordinates specified as floating-point values.
  public init(x: Double, y: Double) {
    self.x = x
    self.y = y
  }

  /// Creates a point with coordinates specified as integer values.
  public init(x: Int, y: Int) {
    self.init(x: Double(x), y: Double(y))
  }

  // MARK - Special Values

  /// The point with location (0,0).
  public static var zero: Point {
    Point(x: 0, y: 0)
  }

  /// Creates a point with location (0,0).
  public init() {
    self.x = 0.0
    self.y = 0.0
  }

  // MARK - Geometric Properties

  /// The x-coordinate of the point.
  public var x: Double

  /// The y-coordinate of the point.
  public var y: Double

  // MARK - Transforming Points

  /// Returns the point resulting from an affine transformation of an existing
  /// point.
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
