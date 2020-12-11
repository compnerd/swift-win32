/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A factory class for creating layout constraint objects using a fluent API.
public class LayoutAnchor<AnchorType: AnyObject> {
  internal unowned var item: AnyObject
  internal var attribute: LayoutConstraint.Attribute

  internal init(item: AnyObject, attribute: LayoutConstraint.Attribute) {
    self.item = item
    self.attribute = attribute
  }

  // MARK - Building Constraints

  /// Returns a constraint that defines one item's attribute as equal to
  /// another.
  public func constraint(equalTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .equal,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: 1.0, constant: 0.0)
  }

  /// Returns a constraint that defines one item's attribute as equal to another
  /// item's attribute plus a constant offset.
  public func constraint(equalTo anchor: LayoutAnchor<AnchorType>,
                         constant offset: Double) -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .equal,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: 1.0, constant: offset)
  }

  /// Returns a constraint that defines one item's attribute as greater than or
  /// equal to another.
  public func constraint(greaterThanOrEqualTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .greaterThanOrEqual,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: 1.0, constant: 0.0)
  }

  /// Returns a constraint that defines one item's attribute as greater than or
  /// equal to another item's attribute plus a constant offset.
  public func constraint(greaterThanOrEqualTo anchor: LayoutAnchor<AnchorType>,
                         constant offset: Double) -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .greaterThanOrEqual,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: 1.0, constant: offset)
  }

  /// Returns a constraint that defines one item's attribute as less than or
  /// equal to another.
  public func constraint(lessThanOrEqualTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .lessThanOrEqual,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: 1.0, constant: 0.0)
  }

  /// Returns a constraint that defines one item's attribute as less than or
  /// equal to another item's attribute plus a constant offset.
  public func constraint(lessThanOrEqualTo anchor: LayoutAnchor<AnchorType>,
                         constannt offset: Double) -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .lessThanOrEqual,
                            toItem: anchor.item, attribute: self.attribute,
                            multiplier: 1.0, constant: offset)
  }
}
