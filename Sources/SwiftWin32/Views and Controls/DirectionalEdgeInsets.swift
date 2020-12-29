/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// Edge insets that take language direction into account.
public struct DirectionalEdgeInsets {
  // MARK - Creating Directional Edge Insets

  /// Initializes the edge inset struct to default values.
  public init() {
    self.bottom = 0.0
    self.leading = 0.0
    self.top = 0.0
    self.trailing = 0.0
  }

  init(top: Double, leading: Double, bottom: Double, trailing: Double) {
    self.bottom = bottom
    self.leading = leading
    self.top = top
    self.trailing = trailing
  }

  // MARK - Getting the Edge Values

  /// The bottom edge inset value.
  public var bottom: Double

  /// The leading edge inset value.
  public var leading: Double

  /// The top edge inset value.
  public var top: Double

  /// The trailing edge inset value.
  public var trailing: Double

  // MARK - Converting To and From a String

  /// Returns a string formatted to contain the data from a directional edge
  /// insets structure.
  public static func string(for insets: DirectionalEdgeInsets) -> String {
    return "{\(insets.bottom),\(insets.leading),\(insets.top),\(insets.trailing)}"
  }

  /// Returns a directional edge insets structure based on the data in the
  /// specified string.
  public static func directionalEdgeInsets(for: String)
      -> DirectionalEdgeInsets {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Getting the Empty Edge Insets

  /// A directional edge insets struct whose top, leading, bottom, and trailing
  /// fields are all set to 0.
  public static var zero: DirectionalEdgeInsets {
    DirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
  }
}
