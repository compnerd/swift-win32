/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A factory class for creating vertical layout constraint objects using a
/// fluent API.
public class LayoutYAxisAnchor: LayoutAnchor<LayoutYAxisAnchor> {
  // MARK - Building System Spacing Constraints

  /// Returns a constraint that defines the specific distance at which the
  /// current anchor is positioned below the specified anchor.
  public func constraint(equalToSystemSpacingBelow anchor: LayoutYAxisAnchor,
                         multiplier: Double) -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .equal, toAnchor: anchor,
                            multiplier: multiplier, constant: 8.0)
  }

  /// Returns a constraint that defines the minimum distance by which the
  /// current anchor is positioned below the specified anchor.
  public func constraint(greaterThanOrEqualToSystemSpacingBelow anchor: LayoutYAxisAnchor,
                         multiplier: Double) -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .greaterThanOrEqual,
                            toAnchor: anchor, multiplier: multiplier,
                            constant: 8.0)
  }

  /// Returns a constraint that defines the maximum distance by which the
  /// current anchor is positioned below the specified anchor.
  public func constraint(lessThanOrEqualToSystemSpacingBelow anchor: LayoutYAxisAnchor,
                         multiplier: Double) -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .lessThanOrEqual,
                            toAnchor: anchor, multiplier: multiplier,
                            constant: 8.0)
  }

  // MARK - Creating a Layout Dimension

  /// Creates a layout dimension object from two anchors.
  public func anchorWithOffset(to anchor: LayoutYAxisAnchor) -> LayoutDimension {
    fatalError("\(#function) not yet implemented")
  }
}
