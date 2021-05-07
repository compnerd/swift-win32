// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A structure that contains the location and dimensions of a rectangle.
public struct Rect {
  // MARK - Creating Rectangle Values

  /// Creates a rectangle with the specified origin and size.
  public init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }

  /// Creates a rectangle with coordinates and dimensions specified as
  /// floating-point values.
  public init(x: Double, y: Double, width: Double, height: Double) {
    self.init(origin: Point(x: x, y: y),
              size: Size(width: width, height: height))
  }

  /// Creates a rectangle with coordinates and dimensions specified as integer
  /// values.
  public init(x: Int, y: Int, width: Int, height: Int) {
    self.init(origin: Point(x: x, y: y),
              size: Size(width: Double(width), height: Double(height)))
  }

  // MARK - Special Values

  /// The rectangle whose origin and size are both zero.
  public static var zero: Rect {
    Rect(x: 0, y: 0, width: 0, height: 0)
  }

  // MARK - Basic Geometric Properties

  /// A point that specifies the coordinates of the rectangle’s origin.
  public var origin: Point

  /// A size that specifies the height and width of the rectangle.
  public var size: Size

  // MARK - Calculated Geometric Properties

  /// Returns the x- coordinate that establishes the center of a rectangle.
  public var midX: Double {
    return self.origin.x + (self.size.width / 2)
  }

  /// Returns the y-coordinate that establishes the center of the rectangle.
  public var midY: Double {
    return self.origin.y + (self.size.height / 2)
  }

  // MARK - Creating Derived Rectangles

  /// Applies an affine transform to a rectangle.
  public func applying(_ transform: AffineTransform) -> Rect {
    let points: [Point] = [
      self.origin,
      self.origin + Point(x: self.size.width, y: 0),
      self.origin + Point(x: 0, y: self.size.height),
      self.origin + Point(x: self.size.width, y: self.size.height),
    ].map { $0.applying(transform) }

    let xs: [Double] = points.map { $0.x }
    let ys: [Double] = points.map { $0.y }
    
    return Rect(origin: Point(x: xs.min()!, y: ys.min()!),
                size: Size( width: xs.max()! - xs.min()!,
                            height: ys.max()! - ys.min()!))
  }
}

extension Rect: Equatable {
}

extension Rect: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Rect(origin: \(origin), size: \(size))"
  }
}
