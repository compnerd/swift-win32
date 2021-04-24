// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
// SPDX-License-Identifier: BSD-3-Clause

/// The layout priority is used to indicate to the constraint-based layout
/// system which constraints are more important, allowing the system to make
/// appropriate tradeoffs when satisfying the constraints of the system as a
/// whole.
public struct LayoutPriority: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = Float

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension LayoutPriority {
  public init(_ rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension LayoutPriority {
  /// A required constraint.
  public static var required: LayoutPriority {
    LayoutPriority(rawValue: 1000.0)
  }

  /// The priority level with which a button resists compressing its content.
  public static var defaultHigh: LayoutPriority {
    LayoutPriority(rawValue: 750.0)
  }

  /// The priority level with which a button hugs its contents horizontally.
  public static var defaultLow: LayoutPriority {
    LayoutPriority(rawValue: 250.0)
  }

  /// The priority level with which the view wants to conform to the target size
  /// in that computation.
  public static var fittingSizeLevel: LayoutPriority {
    LayoutPriority(rawValue: 50.0)
  }

  /// The priority with which a drag may end up resizing the window's scene.
  public static var dragThatCanResizeScene: LayoutPriority {
    LayoutPriority(rawValue: 510.0)
  }

  /// The priority with which the a split view divider is dragged.
  public static var dragThatCannotResizeScene: LayoutPriority {
    LayoutPriority(rawValue: 490.0)
  }

  /// The priority with which the window's scene prefers to stay the same size.
  public static var sceneSizeStayPut: LayoutPriority {
    LayoutPriority(rawValue: 500.0)
  }
}
