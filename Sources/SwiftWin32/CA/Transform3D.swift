/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// The standard transform matrix.
public struct Transform3D {
  // MARK - Initializers

  public init() {
    self.m11 = 0
    self.m12 = 0
    self.m13 = 0
    self.m14 = 0
    self.m21 = 0
    self.m22 = 0
    self.m23 = 0
    self.m24 = 0
    self.m31 = 0
    self.m32 = 0
    self.m33 = 0
    self.m34 = 0
    self.m41 = 0
    self.m42 = 0
    self.m43 = 0
    self.m44 = 0
  }

  public init(m11: Double, m12: Double, m13: Double, m14: Double,
              m21: Double, m22: Double, m23: Double, m24: Double,
              m31: Double, m32: Double, m33: Double, m34: Double,
              m41: Double, m42: Double, m43: Double, m44: Double) {
    self.m11 = m11
    self.m12 = m12
    self.m13 = m13
    self.m14 = m14
    self.m21 = m21
    self.m22 = m22
    self.m23 = m23
    self.m24 = m24
    self.m31 = m31
    self.m32 = m32
    self.m33 = m33
    self.m34 = m34
    self.m41 = m41
    self.m42 = m42
    self.m43 = m43
    self.m44 = m44
  }

  // public init(_ m: float4x4) { }

  // public init(_ m: double4x4) { }

  // MARK - Instance Properties

  /// The entry at position 1,1 in the matrix.
  var m11: Double

  /// The entry at position 1,2 in the matrix.
  var m12: Double

  /// The entry at position 1,3 in the matrix.
  var m13: Double

  /// The entry at position 1,4 in the matrix.
  var m14: Double

  /// The entry at position 2,1 in the matrix.
  var m21: Double

  /// The entry at position 2,2 in the matrix.
  var m22: Double

  /// The entry at position 2,3 in the matrix.
  var m23: Double

  /// The entry at position 2,4 in the matrix.
  var m24: Double

  /// The entry at position 3,1 in the matrix.
  var m31: Double

  /// The entry at position 3,2 in the matrix.
  var m32: Double

  /// The entry at position 3,3 in the matrix.
  var m33: Double

  /// The entry at position 3,4 in the matrix.
  var m34: Double

  /// The entry at position 4,1 in the matrix.
  var m41: Double

  /// The entry at position 4,2 in the matrix.
  var m42: Double

  /// The entry at position 4,3 in the matrix.
  var m43: Double

  /// The entry at position 4,4 in the matrix.
  var m44: Double
}
