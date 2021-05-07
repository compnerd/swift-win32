// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

extension Rect {
  internal init(from: RECT) {
    self.origin = Point(x: from.left, y: from.top)
    self.size = Size(width: from.right - from.left,
                     height: from.bottom - from.top)
  }
}

extension RECT {
  internal init(from: Rect) {
    self.init(left: LONG(from.origin.x),
              top: LONG(from.origin.y),
              right: LONG(from.origin.x + from.size.width),
              bottom: LONG(from.origin.y + from.size.height))
  }
}

extension Rect {
  internal var center: Point {
    Point(x: self.midX, y: self.midY)
  }
}
