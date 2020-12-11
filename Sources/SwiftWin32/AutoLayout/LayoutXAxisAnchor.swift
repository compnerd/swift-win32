/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A factory class for creating horizontal layout constraint objects using a
/// fluent API.
public class LayoutXAxisAnchor: LayoutAnchor<LayoutXAxisAnchor> {
  // MARK - Building System Spacing Constraints

  /// Returns a constraint that defines by how much the current anchor trails
  /// the specified anchor.
  public func constraint(equalToSystemSpacingBelow anchor: LayoutXAxisAnchor,
                         multiplier: Double) -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .equal,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: multiplier, constant: 8.0)
  }

  /// Returns a constraint that defines by how much the current anchor trails
  /// the specified anchor.
  public func constraint(greaterThanOrEqualToSystemSpacingBelow anchor: LayoutXAxisAnchor,
                         multiplier: Double) -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .greaterThanOrEqual,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: multiplier, constant: 8.0)
  }

  /// Returns a constraint that defines the minimum distance by which the
  /// current anchor is positioned below the specified anchor.
  public func constraint(lessThanOrEqualToSystemSpacingBelow anchor: LayoutXAxisAnchor,
                         multiplier: Double) -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .lessThanOrEqual,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: multiplier, constant: 8.0)
  }

  // MARK - Creating a Layout Dimension

  /// Creates a layout dimension object from two anchors.
  public func anchorWithOffset(to anchor: LayoutXAxisAnchor) -> LayoutDimension {
    fatalError("\(#function) not yet implemented")
  }
}
