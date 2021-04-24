// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

extension Size {
  internal init<Integer: FixedWidthInteger>(width: Integer, height: Integer) {
    self.init(width: Int(width), height: Int(height))
  }
}
