/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// An object that specifies the container view to use for animations.
public class PreviewTarget {
  /// Creating a Preview Target Object

  /// Creates a preview target object using the specified container view and
  /// configuration details.
  public init(container: View, center: Point, transform: AffineTransform) {
    self.container = container
    self.center = center
    self.transform = transform
  }

  /// Creates a preview target object using the specified container view and
  /// center point.
  public convenience init(container: View, center: Point) {
    self.init(container: container, center: center, transform: .identity)
  }

  /// Getting the Target Attributes

  /// The container for the view being animated.
  public let container: View

  /// The point in the containing view at which to place the center of the view
  /// being animated.
  public let center: Point

  /// An affine transform to apply to the view being animated.
  public let transform: AffineTransform
}
