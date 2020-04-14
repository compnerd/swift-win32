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

import WinSDK

public extension Rect {
  static let `default`: Rect =
      Rect(x: Double(CW_USEDEFAULT), y: Double(CW_USEDEFAULT),
           width: Double(CW_USEDEFAULT), height: Double(CW_USEDEFAULT))
}

public extension Rect {
  init(from: RECT) {
    self.origin = Point(x: Double(from.left), y: Double(from.top))
    self.size = Size(width: Double(from.right - from.left),
                     height: Double(from.bottom - from.top))
  }

  var isAnyPointDefault: Bool {
    return self.origin.x == Double(CW_USEDEFAULT) ||
           self.origin.y == Double(CW_USEDEFAULT) ||
           self.size.width == Double(CW_USEDEFAULT) ||
           self.size.height == Double(CW_USEDEFAULT)
  }
}

internal extension RECT {
  init(from: Rect) {
    self.init(left: Int32(from.origin.x),
              top: Int32(from.origin.y),
              right: Int32(from.origin.x + from.size.width),
              bottom: Int32(from.origin.y + from.size.height))
  }
}
