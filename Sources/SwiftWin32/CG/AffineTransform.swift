// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import func ucrt.sin
import func ucrt.cos

/// An affine transformation matrix for use in drawing 2D graphics.
public struct AffineTransform {
  // MARK -

  /// The identity transform.
  public static var identity: AffineTransform {
    AffineTransform( a: 1.0,  b: 0.0,
                     c: 0.0,  d: 1.0,
                    tx: 0.0, ty: 0.0)
  }

  // MARK -

  /// The entry at position [1,1] in the matrix.
  public var a: Double

  /// The entry at position [1,2] in the matrix.
  public var b: Double

  /// The entry at position [2,1] in the matrix.
  public var c: Double

  /// The entry at position [2,2] in the matrix.
  public var d: Double

  /// The entry at position [3,1] in the matrix.
  public var tx: Double

  /// The entry at position [3,2] in the matrix.
  public var ty: Double

  /// Checks whether an affine transform is the identity transform.
  public var isIdentity: Bool {
    return self == .identity
  }

  // MARK - Initializers

  public init() {
    self.a = 0.0
    self.b = 0.0
    self.c = 0.0
    self.d = 0.0
    self.tx = 0.0
    self.ty = 0.0
  }

  public init( a: Double,  b: Double,
               c: Double,  d: Double,
              tx: Double, ty: Double) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    self.tx = tx
    self.ty = ty
  }

  /// Returns an affine transformation matrix constructed from a rotation value
  /// you provide.
  public init(rotationAngle radians: Double) {
    let sine: Double = sin(radians)
    let cosine: Double = cos(radians)

    self.init( a: cosine, b: sine,
               c: -sine,  d: cosine,
              tx: 0.0,   ty: 0.0)
  }

  /// Returns an affine transformation matrix constructed from scaling values
  /// you provide.
  public init(scaleX sx: Double, y sy: Double) {
    self.init( a: sx,   b: 0.0,
               c: 0.0,  d: sy,
              tx: 0.0, ty: 0.0)
  }

  /// Returns an affine transformation matrix constructed from translation
  /// values you provide.
  public init(translationX tx: Double, y ty: Double) {
    self.init( a: 1.0,  b: 0.0,
               c: 0.0,  d: 1.0,
              tx: tx,  ty: ty)
  }

  // MARK -

  /// Returns an affine transformation matrix constructed by combining two
  /// existing affine transforms.
  public func concatenating(_ transform: AffineTransform) -> AffineTransform {
    return AffineTransform(a: self.a * transform.a + self.b * transform.c,
                           b: self.a * transform.b + self.b * transform.d,
                           c: self.c * transform.a + self.d * transform.c,
                           d: self.c * transform.b + self.d * transform.d,
                           tx: self.tx * transform.a + self.ty * transform.c + transform.tx,
                           ty: self.tx * transform.b + self.ty * transform.d + transform.ty)
  }

  /// Returns an affine transformation matrix constructed by inverting an
  /// existing affine transform.
  public func inverted() -> AffineTransform {
    let determinant = self.a * self.d - self.b * self.c

    // The matrix is in-invertible if the determinant is 0.
    if determinant == 0 { return self }

    let a = self.d / determinant
    let b = -self.b / determinant
    let c = -self.c / determinant
    let d = self.a / determinant

    return AffineTransform(a: a, b: b, c: c, d: d,
                           tx: -a * self.tx - c * self.ty,
                           ty: -b * self.tx - d * self.ty)
  }
}

extension AffineTransform: Equatable {
}
