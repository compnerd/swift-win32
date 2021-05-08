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

  /// The null rectangle, representing an invalid value.
  public static var null: Rect {
    Rect(x: .greatestFiniteMagnitude, y: .greatestFiniteMagnitude,
         width: 0.0, height: 0.0)
  }

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

  /// Returns the height of a rectangle.
  public var height: Double {
    return self.size.height
  }

  /// Returns the width of a rectangle.
  public var width: Double {
    return self.size.width
  }

  /// Returns the smallest value for the x-coordinate of the rectangle.
  public var minX: Double {
    return self.origin.x
  }

  /// Returns the x-coordinate that establishes the center of a rectangle.
  public var midX: Double {
    return self.origin.x + (self.size.width / 2)
  }

  /// Returns the largest value of the x-coordinate for the rectangle.
  public var maxX: Double {
    return self.origin.x + self.size.width
  }

  /// Returns the smallest value for the y-coordinate of the rectangle.
  public var minY: Double {
    return self.origin.y
  }

  /// Returns the y-coordinate that establishes the center of the rectangle.
  public var midY: Double {
    return self.origin.y + (self.size.height / 2)
  }

  /// Returns the largest value for the y-coordinate of the rectangle.
  public var maxY: Double {
    return self.origin.y + self.size.height
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

  /// Returns a rectangle with an origin that is offset from that of the source
  /// rectangle.
  public func offsetBy(dx: Double, dy: Double) -> Rect {
    guard !self.isNull else { return self }
    return Rect(x: self.origin.x + dx, y: self.origin.y + dy,
                width: self.size.width, height: self.size.height)
  }

  // MARK - Checking Characteristics

  /// Returns whether the rectangle is equal to the null rectangle.
  public var isNull: Bool {
    return self == .null
  }
}

extension Rect: Equatable {
}

extension Rect: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Rect(origin: \(origin), size: \(size))"
  }
}
