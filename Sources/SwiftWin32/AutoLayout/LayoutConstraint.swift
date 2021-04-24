// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
// SPDX-License-Identifier: BSD-3-Clause

extension LayoutConstraint {
  /// The relation between the first attribute and the modified second attribute
  /// in a constraint.
  public enum Relation: Int {
  /// The constraint requires the first attribute to be less than or equal to
  /// the modified second attribute.
  case lessThanOrEqual

  /// The constraint requires the first attribute to be exactly equal to the
  /// modified second attribute.
  case equal

  /// The constraint requires the first attribute to be greater than or equal to
  /// the modified second attribute.
  case greaterThanOrEqual
  }
}

extension LayoutConstraint {
  /// The part of the object's visual representation that should be used to get
  /// the value for the constraint.
  public enum Attribute: Int {
  /// The left side of the object's alignment rectangle.
  case left

  /// The right side of  the object's alignment rectangle.
  case right

  /// The top of the object's alignment rectangle.
  case top

  /// The bottom of the object's alignment rectangle.
  case bottom

  /// The leading edge of the object's alignment rectangle.
  case leading

  /// The trailing edge of the object's alignment rectangle.
  case trailing

  /// The width of the object's alignment rectangle.
  case width

  /// The height of the object's alignment rectangle.
  case height

  /// Tne center along the x-axis of the object's alignment rectangle.
  case centerX

  /// The center along the y-axis of the object's alignment rectangle.
  case centerY

  /// The object's baseline.  For objects with more than one line of text, this
  /// is the baseline for the bottom-most line of text.
  case lastBaseline

  /// The object's baseline.  For objects with more than one line of text, this
  /// is the baseline for the top-most line of text.
  case firstBaseline

  /// The object's left margin.  For `View` objects, the margins are defined by
  /// their `layoutMargins` property.
  case leftMargin

  /// The object's right margin.  For `View` objects, the margins are defined by
  /// their `layoutMargins` property.
  case rightMargin

  /// The object's top margin.  For `View` objects, the margins are defined by
  /// their `layoutMargins` property.
  case topMargin

  /// The object's bottom margin.  For `View` objects, the margins are defined
  /// by their `layoutMargins` property.
  case bottomMargin

  /// The object's leading margin.  For `View` objects, the margins are defined
  /// by their `layoutMargins` property.
  case leadingMargin

  /// The object's trailing margin.  For `View` objects, the margins are defined
  /// by thier `layoutMargins` property.
  case trailingMargin

  /// The center along the x-axis between the object's left and right margin.
  /// For `View` objects, the margins are defined by their `layoutMargins`
  /// property.
  case centerXWithinMargins

  /// The center along the y-axis between the object's top and bottom margin.
  /// For `View` objects, the margins are defined by thier `layoutMargins`
  /// property.
  case centerYWithinMargins

  /// A placeholder value that is used to indicate taht the constraint's second
  /// item and second attribute are not used in any calculations.
  case notAnAttribute
  }
}

public class LayoutConstraint {
  // MARK - Creating Constraints

  /// Creates a constraint that defines the relationship between the specified
  /// attributes of the given views.
  public /*convenience*/ init(item firstItem: AnyObject,
                              attribute firstAttribute: LayoutConstraint.Attribute,
                              relatedBy relation: LayoutConstraint.Relation,
                              toItem secondItem: AnyObject?,
                              attribute secondAttribute: LayoutConstraint.Attribute,
                              multiplier: Double, constant: Double) {
    self.firstAnchor =
        LayoutAnchor<AnyObject>(item: firstItem, attribute: firstAttribute)

    if let item = secondItem {
      self.secondAnchor =
          LayoutAnchor<AnyObject>(item: item, attribute: secondAttribute)
    }

    self.relation = relation
    self.multiplier = multiplier
    self.constant = constant
  }

  // MARK - Activating and Deactivating Constraints

  /// The active state of the constraint.
  public var isActive: Bool = false {
    didSet {
      var ancestor: View? = self.firstAnchor.item as? View
      if let other = self.secondAnchor?.item as? View {
        // TODO(compnerd) this has performance implications - O(n²) for the
        // check for the common ancestor search.
        while let parent = ancestor, !other.isDescendant(of: parent) {
          ancestor = parent.superview
        }
      }

      switch isActive {
      case true:
        ancestor?.addConstraint(self)
      case false:
        ancestor?.removeConstraint(self)
      }
    }
  }

  /// Activates each constraint in the specified array.
  public class func activate(_ constraints: [LayoutConstraint]) {
    constraints.forEach { $0.isActive = true }
  }

  /// Deactivates each constraint in the specified array.
  public class func deactivate(_ constraints: [LayoutConstraint]) {
    constraints.forEach { $0.isActive = false }
  }

  // MARK - Accessing Constraint Data

  /// The first object participating in the constraint.
  public unowned(unsafe) var firstItem: AnyObject? {
    firstAnchor.item
  }

  /// The attribute of the first object participating in the constraint.
  public var firstAttribute: LayoutConstraint.Attribute {
    firstAnchor.attribute
  }

  /// The relationship between the two attributes in the constraint.
  public private(set) var relation: LayoutConstraint.Relation

  /// The second object participating in the constraint.
  public unowned(unsafe) var secondItem: AnyObject? {
    secondAnchor?.item
  }

  /// The attribute of the second object participating in the constraint.
  public var secondAttribute: LayoutConstraint.Attribute {
    secondAnchor?.attribute ?? .notAnAttribute
  }

  /// The multiplier applied to the second attribute participating in the
  /// constraint.
  public private(set) var multiplier: Double

  /// The constant added to the multiplied second attribute participating in the
  /// constraint.
  public private(set) var constant: Double

  /// The first anchor that defines the constraint.
  public private(set) var firstAnchor: LayoutAnchor<AnyObject>

  /// The second anchor that defines the constraint.
  public private(set) var secondAnchor: LayoutAnchor<AnyObject>?

  // MARK - Getting the Layout Priority

  /// The priority of the constraint.
  public var priority: LayoutPriority = .required

  // MARK - Identifying a Constraint

  /// The name that identifies the constraint.
  public var identifier: String?
}
