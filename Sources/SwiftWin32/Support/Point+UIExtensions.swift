/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

extension Point {
  internal init(from: POINT) {
    self.init(x: Double(from.x), y: Double(from.y))
  }
}

extension POINT {
  internal init(from: Point) {
    self.init(x: LONG(from.x), y: LONG(from.y))
  }
}

extension Size {
  internal init(from: POINT) {
    self.init(width: Double(from.x), height: Double(from.y))
  }
}

extension POINT {
  internal init(from: Size) {
    self.init(x: LONG(from.width), y: LONG(from.height))
  }
}

extension Point {
  internal init<Integer: FixedWidthInteger>(x: Integer, y: Integer) {
    self.init(x: Int(x), y: Int(y))
  }
}
