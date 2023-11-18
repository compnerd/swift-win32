// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if swift(>=5.7)
import CoreAnimation
import CoreGraphics
#endif

/// Provides movement hint information for the focused item.
public class FocusMovementHint {
  // MARK -

  internal init () {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Moving Focus

  /// A vector representing how close focus is to moving to another item in the
  /// swiped direction.
  public private(set) var movementDirection: Vector

  // MARK - Transforming a Hint

  /// A 3D transform that contains the combined transformations of perspective,
  /// rotation, and translation.
  public private(set) var interactionTransform: Transform3D

  /// A 3D transform that represents a perspective matrix to be applied to match
  /// the system interaction hinting.
  public private(set) var perspectiveTransform: Transform3D

  /// A vector to apply to a transform to match system interaction hinting.
  public private(set) var rotation: Vector

  /// A vector to apply to a transform to match system interaction hinting.
  public private(set) var translation: Vector
}
