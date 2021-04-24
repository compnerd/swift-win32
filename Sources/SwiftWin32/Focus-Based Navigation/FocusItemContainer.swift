// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The container responsible for providing geometric context to focus items
/// within a given focus environment.
public protocol FocusItemContainer {
  // MARK - Retrieving Focus Items

  /// Retrieves all of the focus items within this container that intersect with
  /// the provided rectangle.
  func focusItems(in rect: Rect) -> [FocusItem]

  /// The coordinate space of the focus items contained in the focus item
  /// container.
  var coordinateSpace: CoordinateSpace { get }
}
