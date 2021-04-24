// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
// SPDX-License-Identifier: BSD-3-Clause

/// A factory class for creating size-based layout constraint objects using a
/// fluent API.
public class LayoutDimension: LayoutAnchor<LayoutDimension> {
  // MARK - Building Constraints

  /// Returns a constraint that defines the anchor's size attribute as equal to
  /// the specified anchor multiplied by the constant.
  public func constraint(equalTo anchor: LayoutDimension, multiplier: Double)
      -> LayoutConstraint {
    return constraint(equalTo: anchor, multiplier: multiplier, constant: 0.0)
  }

  /// Returns a constraint that defines the anchor's size attribute as equal to
  /// the specified size attribute multiplied by a constant plus an offset.
  public func constraint(equalTo anchor: LayoutDimension, multiplier: Double,
                         constant offset: Double) -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .equal,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: multiplier, constant: offset)
  }

  /// Returns a constraint that defines a constant size for the anchor's size
  /// attribute.
  public func constraint(equalToConstant constant: Double) -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute,
                            multiplier: 1.0, constant: constant)
  }

  /// Returns a constraint that defines the anchor's size attribute as greater
  /// than or equal to the specified anchor multiplied by the constant.
  public func constraint(greaterThanOrEqualTo anchor: LayoutDimension,
                         multiplier: Double) -> LayoutConstraint {
    return constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier,
                      constant: 0.0)
  }

  /// Returns a constraint that defines teh anchor's size attribute greater than
  /// or equal to the specified anchor multiplied by the constant plus an
  /// offset.
  public func constraint(greaterThanOrEqualTo anchor: LayoutDimension,
                         multiplier: Double, constant offset: Double)
      -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .greaterThanOrEqual,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: multiplier, constant: offset)
  }

  /// Returns a constraint that defines the minimum size for the anchor's size
  /// attribute.
  public func constraint(greaterThanOrEqualToConstant constant: Double)
      -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .greaterThanOrEqual,
                            toItem: nil, attribute: .notAnAttribute,
                            multiplier: 1.0, constant: constant)
  }

  /// Returns a constraint that defines the anchor's size attribute as less than
  /// or requal to the specified anchor multiplied by the constant.
  public func constraint(lessThanOrEqualTo anchor: LayoutDimension,
                         multiplier: Double) -> LayoutConstraint {
    return constraint(lessThanOrEqualTo: anchor, multiplier: multiplier,
                      constant: 0.0)
  }

  /// Returns a constraint that defines the anchor's size attribute as greater
  /// than or equal to the specified anchor multiplied by the constant plus an
  /// offset.
  public func constraint(lessThanOrEqualTo anchor: LayoutDimension,
                         multiplier: Double, constant offset: Double)
      -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .lessThanOrEqual,
                            toItem: anchor.item, attribute: anchor.attribute,
                            multiplier: multiplier, constant: offset)
  }

  /// Returns a constraint that defines the maximum size for teh anchor's size
  /// attribute.
  public func constraint(lessThanOrEqualToConstant constant: Double)
      -> LayoutConstraint {
    return LayoutConstraint(item: self.item, attribute: self.attribute,
                            relatedBy: .lessThanOrEqual,
                            toItem: nil, attribute: .notAnAttribute,
                            multiplier: 1.0, constant: constant)
  }
}
