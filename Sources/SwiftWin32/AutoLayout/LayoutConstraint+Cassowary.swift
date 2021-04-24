// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
// SPDX-License-Identifier: BSD-3-Clause

import Cassowary

extension LayoutConstraint.Attribute {
  internal var name: String {
    switch self {
    case .left: return "Left"
    case .right: return "Right"
    case .top: return "Top"
    case .bottom: return "Bottom"
    case .leading: return "Leading"
    case .trailing: return "Trailing"
    case .width: return "Width"
    case .height: return "Height"
    case .centerX: return "CenterX"
    case .centerY: return "CenterY"
    case .lastBaseline: return "lastBaseline"
    case .firstBaseline: return "FirstBaseline"
    case .leftMargin: return "LeftMargin"
    case .rightMargin: return "RightMargin"
    case .topMargin: return "TopMargin"
    case .bottomMargin: return "BottomMargin"
    case .leadingMargin: return "LeadingMargin"
    case .trailingMargin: return "TrailingMargin"
    case .centerXWithinMargins: return "CenterXWithinMargins"
    case .centerYWithinMargins: return "CenterYWithinMargins"
    case .notAnAttribute: return "NotAnAttribute"
    }
  }
}

extension LayoutAnchor {
  internal var variable: Variable {
    Variable("\(type(of: self.item)):0x\(String(UInt(bitPattern: ObjectIdentifier(self.item)), radix: 16)).\(self.attribute.name)")
  }
}

extension LayoutConstraint {
  internal var constraint: Constraint {
    let lhs = firstAnchor.variable
    let rhs: Cassowary.Variable? = secondAnchor?.variable

    switch self.relation {
    case .lessThanOrEqual:
      if let rhs = rhs {
        return Constraint(lhs <= rhs * self.multiplier + self.constant, .required)
      }
      return Constraint(lhs <= self.constant, .required)

    case .equal:
      if let rhs = rhs {
        return Constraint(lhs * self.multiplier + self.constant == rhs, .required)
      }
      return Constraint(lhs * self.multiplier == self.constant, .required)

    case .greaterThanOrEqual:
      if let rhs = rhs {
        return Constraint(lhs * self.multiplier + self.constant >= rhs, .required)
      }
      return Constraint(lhs * self.multiplier >= self.constant, .required)
    }
  }
}
