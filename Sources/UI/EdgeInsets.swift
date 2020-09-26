/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public class EdgeInsets {
  public static let zero: EdgeInsets = EdgeInsets()

  public let bottom: Double
  public let left: Double
  public let right: Double
  public let top: Double

  public init() {
    self.bottom = 0.0
    self.left = 0.0
    self.right = 0.0
    self.top = 0.0
  }

  public init(top: Double, left: Double, bottom: Double, right: Double) {
    self.bottom = bottom
    self.left = left
    self.right = right
    self.top = top
  }
}

extension EdgeInsets: Equatable {
  public static func == (_ lhs: EdgeInsets, _ rhs: EdgeInsets) -> Bool {
    return lhs.bottom == rhs.bottom &&
           lhs.left == rhs.left &&
           lhs.right == rhs.right &&
           lhs.top == rhs.top
  }
}
