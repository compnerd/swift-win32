/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A set of methods that provide layout support and access to layout anchors.
public protocol LayoutSupport {
  // MARK - Layout Support

  /// Provides the length, in points, of the portion of the view controller's
  /// view that is overlaid by translucent or transparent bars.
  var length: Double { get }

  // MARK - Creating Constraints Using Layout Anchors

  /// A layout anchor representing the guide's bottom edge.
  var bottomAnchor: LayoutYAxisAnchor { get }

  /// A layout anchor repreenting the guide's height.
  var heightAnchor: LayoutDimension { get }

  /// A layout anchor representing the guide's top edge.
  var topAnchor: LayoutYAxisAnchor { get }
}
