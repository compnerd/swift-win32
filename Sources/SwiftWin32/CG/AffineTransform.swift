// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import func ucrt.sin
import func ucrt.cos

public struct AffineTransform {
  public static let identity: AffineTransform =
      AffineTransform( a: 1.0,  b: 0.0,
                       c: 0.0,  d: 1.0,
                      tx: 0.0, ty: 0.0)

  public var a: Double
  public var b: Double
  public var c: Double
  public var d: Double
  public var tx: Double
  public var ty: Double

  public var isIdentity: Bool { return self == .identity }

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

  public init(rotationAngle radians: Double) {
    let sine: Double = sin(radians)
    let cosine: Double = cos(radians)

    self.init( a: cosine, b: sine,
               c: -sine,  d: cosine,
              tx: 0.0,   ty: 0.0)
  }

  public init(scaleX sx: Double, y sy: Double) {
    self.init( a: sx,   b: 0.0,
               c: 0.0,  d: sy,
              tx: 0.0, ty: 0.0)
  }

  public init(translationX tx: Double, y ty: Double) {
    self.init( a: 1.0,  b: 0.0,
               c: 0.0,  d: 1.0,
              tx: tx,  ty: ty)
  }

  public func concatenating(_ transform: AffineTransform) -> AffineTransform {
    return AffineTransform(a: self.a * transform.a + self.b * transform.c,
                           b: self.a * transform.b + self.b * transform.d,
                           c: self.c * transform.a + self.d * transform.c,
                           d: self.c * transform.b + self.d * transform.d,
                           tx: self.tx * transform.a + self.ty * transform.c + transform.tx,
                           ty: self.tx * transform.b + self.ty * transform.d + transform.ty)
  }

  public func inverted() -> AffineTransform {
    let determinant = a * d - b * c
    let (newA, newB, newC, newD) = (d/determinant, -b/determinant,
                                   -c/determinant,  a/determinant)
    let (newTX, newTY) = (-newA * tx - newC * ty, -newB * tx - newD * ty)
    let invertedTransform = 
      AffineTransform( a: newA,  b: newB,
                       c: newC,  d: newD,
                      tx: newTX, ty: newTY)
    return invertedTransform
  }
}

extension AffineTransform: Equatable {
}
