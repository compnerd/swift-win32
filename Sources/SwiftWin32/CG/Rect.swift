// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

@_implementationOnly import func CRT.floor
@_implementationOnly import func CRT.ceil

@inline(__always)
private func __equals(_ lhs: Rect, _ rhs: Rect) -> Bool {
  return lhs.origin == rhs.origin && lhs.size == rhs.size
}

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

  /// A rectangle that has infinite extent.
  public static var infinite: Rect {
    Rect(x: -.leastNormalMagnitude, y: -.leastNormalMagnitude,
         width: .greatestFiniteMagnitude, height:.greatestFiniteMagnitude)
  }

  /// The null rectangle, representing an invalid value.
  public static var null: Rect {
    Rect(x: .greatestFiniteMagnitude, y: .greatestFiniteMagnitude,
         width: 0.0, height: 0.0)
  }

  /// The rectangle whose origin and size are both zero.
  public static var zero: Rect {
    Rect(x: 0, y: 0, width: 0, height: 0)
  }

  /// Creates a rectangle with origin (0,0) and size (0,0).
  public init() {
    self = .zero
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

  /// Returns a rectangle with a positive width and height.
  public var standardized: Rect {
    guard !self.isNull else { return .null }

    guard self.size.width < 0 || self.size.height < 0 else { return self }
    return Rect(x: self.origin.x + (self.width < 0 ? self.width : 0),
                y: self.origin.y + (self.height < 0 ? self.height : 0),
                width: abs(self.width), height: abs(self.height))
  }

  /// Returns the smallest rectangle that results from converting the source
  /// rectangle values to integers.
  public var integral: Rect {
    guard !self.isNull else { return .null }

    let standardized = self.standardized
    let origin: Point = Point(x: floor(standardized.minX),
                              y: floor(standardized.minY))
    let size: Size = Size(width: ceil(standardized.maxX) - origin.x,
                          height: ceil(standardized.maxY) - origin.y)
    return Rect(origin: origin, size: size)
  }

  /// Applies an affine transform to a rectangle.
  public func applying(_ transform: AffineTransform) -> Rect {
    guard !self.isNull else { return .null }
    if transform.isIdentity { return self.standardized }

    let points: [Point] = [
      Point(x: minX, y: minY),  // top left
      Point(x: maxX, y: minY),  // top right
      Point(x: minX, y: maxY),  // bottom left
      Point(x: maxX, y: maxY),  // bottom right
    ].map { $0.applying(transform) }

    let (minX, minY, maxX, maxY): (Double, Double, Double, Double) =
        points.map { ($0.x, $0.y) }
              .reduce((.infinity, .infinity, -.infinity, -.infinity), {
          (min($0.0, $1.0), min($0.1, $1.1), max($0.2, $1.0), max($0.3, $1.1))
        })

    return Rect(origin: Point(x: minX, y: minY),
                size: Size(width: maxX - minX, height: maxY - minY))
  }

  /// Returns a rectangle that is smaller or larger than the source rectangle,
  /// with the same center point.
  public func insetBy(dx: Double, dy: Double) -> Rect {
    let standardized = self.standardized
    let origin: Point =
        Point(x: standardized.minX + dx, y: standardized.minY + dy)
    let size: Size = Size(width: standardized.width - 2 * dx,
                          height: standardized.height - 2 * dy)
    guard size.width > 0, size.height > 0 else { return .null }
    return Rect(origin: origin, size: size)
  }

  /// Returns a rectangle with an origin that is offset from that of the source
  /// rectangle.
  public func offsetBy(dx: Double, dy: Double) -> Rect {
    guard !self.isNull else { return self }

    let standardized = self.standardized
    return Rect(x: standardized.origin.x + dx,
                y: standardized.origin.y + dy,
                width: standardized.size.width,
                height: standardized.size.height)
  }

  /// Returns the smallest rectangle that contains the two source rectangles.
  public func union(_ rect: Rect) -> Rect {
    guard !self.isNull else { return rect }
    guard !rect.isNull else { return self }
    let lhs: Rect = self.standardized, rhs: Rect = rect.standardized

    let origin: Point = Point(x: min(lhs.minX, rhs.minX),
                              y: min(lhs.minY, rhs.minY))
    let size: Size = Size(width: max(lhs.maxX, rhs.maxX) - origin.x,
                          height: max(lhs.maxY, rhs.maxY) - origin.y)
    return Rect(origin: origin, size: size)
  }

  /// Returns the intersection of two rectangles.
  public func intersection(_ rect: Rect) -> Rect {
    guard !self.isNull, !rect.isNull else { return .null }
    let lhs: Rect = self.standardized, rhs: Rect = rect.standardized

    let origin: Point = Point(x: max(lhs.minX, rhs.minX),
                              y: max(lhs.minY, rhs.minY))
    let size: Size = Size(width: min(lhs.maxX, rhs.maxX) - origin.x,
                          height: min(lhs.maxY, rhs.maxY) - origin.y)
    guard size.width > 0, size.height > 0 else { return .null }
    return Rect(origin: origin, size: size)
  }

  // MARK - Checking Characteristics

  /// Returns whether two rectangles intersect.
  public func intersects(_ rect: Rect) -> Bool {
    return !intersection(rect).isEmpty
  }

  /// Returns whether a rectangle contains a specified point.
  public func contains(_ point: Point) -> Bool {
    guard !self.isNull else { return false }
    let standardized: Rect = self.standardized
    return standardized.minX...standardized.maxX ~= point.x
        && standardized.minY...standardized.maxY ~= point.y
  }

  /// Returns whether the first rectangle contains the second rectangle.
  public func contains(_ rect2: Rect) -> Bool {
    return self == self.union(rect2)
  }

  /// Returns whether a rectangle has zero width or height, or is a null
  /// rectangle.
  public var isEmpty: Bool {
    return self.size.height == 0 || self.size.width == 0 || self.isNull
  }

  /// Returns whether a rectangle is infinite.
  public var isInfinite: Bool {
    return self == .infinite
  }

  /// Returns whether the rectangle is equal to the null rectangle.
  public var isNull: Bool {
    return __equals(self, .null)
  }
}

extension Rect: Equatable {
  // MARK - Operator Functions
  public static func == (lhs: Rect, rhs: Rect) -> Bool {
    let lhs: Rect = lhs.standardized, rhs: Rect = rhs.standardized
    return __equals(lhs, rhs)
  }
}

extension Rect: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Rect(origin: \(origin), size: \(size))"
  }
}
