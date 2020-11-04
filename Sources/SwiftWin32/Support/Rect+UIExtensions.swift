/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

extension Rect {
  internal init(from: RECT) {
    self.origin = Point(x: Double(from.left), y: Double(from.top))
    self.size = Size(width: Double(from.right - from.left),
                     height: Double(from.bottom - from.top))
  }
}

extension RECT {
  internal init(from: Rect) {
    self.init(left: Int32(from.origin.x),
              top: Int32(from.origin.y),
              right: Int32(from.origin.x + from.size.width),
              bottom: Int32(from.origin.y + from.size.height))
  }
}
