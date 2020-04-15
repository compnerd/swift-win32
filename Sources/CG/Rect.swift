/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
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

public struct Rect {
  public static let zero: Rect = Rect(x: 0, y: 0, width: 0, height: 0)

  public var origin: Point
  public var size: Size

  public init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }

  public init(x: Double, y: Double, width: Double, height: Double) {
    self.init(origin: Point(x: x, y: y),
              size: Size(width: width, height: height))
  }

  public init(x: Int, y: Int, width: Int, height: Int) {
    self.init(origin: Point(x: Double(x), y: Double(y)),
              size: Size(width: Double(width), height: Double(height)))
  }

  func applying(_ transform: AffineTransform) -> Rect {
    return Rect(origin: self.origin.applying(transform),
                size: self.size.applying(transform))
  }
}

extension Rect: Equatable {
}

extension Rect: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Rect(origin: \(origin), size: \(size))"
  }
}
