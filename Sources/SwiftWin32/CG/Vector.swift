/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A structure that contains a two-dimensional vector.
public struct Vector {
  // MARK - Special Values

  /// The vector whose components are both zero.
  static let zero: Vector = Vector(dx: 0.0, dy: 0.0)

  /// Creates a vector whose components are both zero.
  public init() {
    self.dx = 0.0
    self.dy = 0.0
  }

  // MARK - Geometric Properties

  /// The x component of the vector.
  public var dx: Double

  /// The y component of the vector.
  public var dy: Double

  // MARK - Initializers

  /// Creates a vector with components specified as floating-point values.
  public init(dx: Double, dy: Double) {
    self.dx = dx
    self.dy = dy
  }

  /// Creates a vector with components specified as floating-point values.
  public init(dx: Float, dy: Float) {
    self.dx = Double(dx)
    self.dy = Double(dy)
  }

  /// Creates a vector with components specified as integer values.
  public init(dx: Int, dy: Int) {
    self.dx = Double(dx)
    self.dy = Double(dy)
  }
}

extension Vector: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "(\(dx), \(dy))"
  }
}

extension Vector: Decodable {
}

extension Vector: Encodable {
}

extension Vector: Equatable {
}
