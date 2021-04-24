// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// An object that can become focused.
public protocol FocusItem: FocusEnvironment {
  // MARK - Determining Focusability

  /// A boolean value that indicates whether the item can become focused.
  var canBecomeFocused: Bool { get }

  /// A boolean value indicating whether the item is currently focused.
  var isFocused: Bool { get }

  // MARK - Retrieving the Item Frame

  /// The geometric frame of the item.
  var frame: Rect { get }

  // MARK - Providing Movement Hints

  func didHintFocusMovement(_ hint: FocusMovementHint)
}

extension FocusItem {
  public var isFocused: Bool { false }
}

extension FocusItem {
  public func didHintFocusMovement(_ hint: FocusMovementHint) {
  }
}
