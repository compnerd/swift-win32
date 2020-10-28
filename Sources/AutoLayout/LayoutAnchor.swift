/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A factory class for creating layout constraint objects using a fluent API.
public class LayoutAnchor<AnchorType: AnyObject> {
  internal weak var item: AnyObject?
  internal var attribute: LayoutConstraint.Attribute

  internal init(item: AnyObject?, attribute: LayoutConstraint.Attribute) {
    self.item = item
    self.attribute = attribute
  }

  // MARK - Building Constraints

  /// Returns a constraint that defines one item's attribute as equal to
  /// another.
  public func constraint(equalTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .equal, toAnchor: anchor,
                            multiplier: 1.0, constant: 0.0)
  }

  /// Returns a constraint that defines one item's attribute as equal to another
  /// item's attribute plus a constant offset.
  public func constraint(equalTo anchor: LayoutAnchor<AnchorType>,
                         constant offset: Double) -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .equal, toAnchor: anchor,
                            multiplier: 1.0, constant: offset)
  }

  /// Returns a constraint that defines one item's attribute as greater than or
  /// equal to another.
  public func constraint(greaterThanOrEqualTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .greaterThanOrEqual,
                            toAnchor: anchor, multiplier: 1.0, constant: 0.0)
  }

  /// Returns a constraint that defines one item's attribute as greater than or
  /// equal to another item's attribute plus a constant offset.
  public func constraint(greaterThanOrEqualTo anchor: LayoutAnchor<AnchorType>,
                         constant offset: Double) -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .greaterThanOrEqual,
                            toAnchor: anchor, multiplier: 1.0, constant: offset)
  }

  /// Returns a constraint that defines one item's attribute as less than or
  /// equal to another.
  public func constraint(lessThanOrEqualTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .lessThanOrEqual,
                            toAnchor: anchor, multiplier: 1.0, constant: 0.0)
  }

  /// Returns a constraint that defines one item's attribute as less than or
  /// equal to another item's attribute plus a constant offset.
  public func constraint(lessThanOrEqualTo anchor: LayoutAnchor<AnchorType>,
                         constannt offset: Double) -> LayoutConstraint {
    return LayoutConstraint(anchor: self, relatedBy: .lessThanOrEqual,
                            toAnchor: anchor, multiplier: 1.0, constant: offset)
  }
}

extension LayoutAnchor {
  internal var generic: LayoutAnchor<AnyObject> {
    LayoutAnchor<AnyObject>(item: self.item, attribute: self.attribute)
  }
}
