// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A set of methods for converting between different frames of reference on a
/// screen.
public protocol CoordinateSpace {
  /// Getting the Bounds Rectangle

  /// The bounds rectangle describing the item's location and size in its own
  /// coordinate system.
  var bounds: Rect { get }

  /// Converting Between Coordinate Spaces

  /// Converts a point from the coordinate space of the current object to the
  /// specified coordinate space.
  func convert(_: Point, to: CoordinateSpace) -> Point

  /// Converts a point from the specified coordinate space to the coordinate
  /// space of the current object.
  func convert(_: Point, from: CoordinateSpace) -> Point

  /// Converts a rectangle from the coordinate space of the current object to
  /// the specified coordinate space.
  func convert(_: Rect, to: CoordinateSpace) -> Rect

  /// Converts a rectangle from the specified coordinate space to the coordinate
  /// space of the current object.
  func convert(_: Rect, from: CoordinateSpace) -> Rect
}
