/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
}

extension AffineTransform: Equatable {
}
