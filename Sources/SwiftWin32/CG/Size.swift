// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A structure that contains width and height values.
public struct Size {
  // MARK - Geometric Properties

  /// A width value.
  public var width: Double

  /// A height value.
  public var height: Double

  // MARK - Special Values

  /// The size whose width and height are both zero.
  public static var zero: Size {
    Size(width: 0, height: 0)
  }

  /// Creates a size with zero width and height.
  public init() {
    self = .zero
  }

  // MARK - Transforming Sizes

  /// Returns the height and width resulting from a transformation of an
  /// existing height and width.
  func applying(_ transform: AffineTransform) -> Size {
    return Size(width: transform.a * self.width + transform.c * self.height,
                height: transform.b * self.width + transform.d * self.height)
  }

  // MARK - Initializers

  /// Creates a size with dimensions specified as floating-point values.
  public init(width: Double, height: Double) {
    self.height = height
    self.width = width
  }

  public init(width: Int, height: Int) {
    self.init(width: Double(width), height: Double(height))
  }
}

extension Size: Equatable {
}

extension Size: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Size(width: \(width), height: \(height))"
  }
}
