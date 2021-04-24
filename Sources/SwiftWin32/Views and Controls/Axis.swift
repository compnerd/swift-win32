// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// Defines a structure that specifies the layout axes.
public struct Axis: OptionSet {
  public typealias RawValue = UInt

  public let rawValue: RawValue

  // MARK - Initializers

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension Axis {
  public static var both: Axis {
    [.horizontal, .vertical]
  }

  public static var horizontal: Axis {
    Axis(rawValue: 1 << 0)
  }

  public static var vertical: Axis {
    Axis(rawValue: 1 << 1)
  }
}
