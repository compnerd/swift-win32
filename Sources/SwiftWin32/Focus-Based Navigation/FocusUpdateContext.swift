// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.NSNotification

/// The general type of an event.
public struct FocusHeading: OptionSet {
  public typealias RawValue = UInt

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension FocusHeading {
  internal static var none: FocusHeading {
    FocusHeading(rawValue: 0 << 0)
  }

  /// The focus update is heading in the up direction.
  public static var up: FocusHeading {
    FocusHeading(rawValue: 1 << 0)
  }

  /// The focus update is heading in the down direction.
  public static var down: FocusHeading {
    FocusHeading(rawValue: 1 << 1)
  }

  /// The focus update is heading in the left direction.
  public static var left: FocusHeading {
    FocusHeading(rawValue: 1 << 2)
  }

  /// The focus update is heading in the right direction.
  public static var right: FocusHeading {
    FocusHeading(rawValue: 1 << 3)
  }

  /// The focus update is heading to the next item.
  public static var next: FocusHeading {
    FocusHeading(rawValue: 1 << 4)
  }

  /// The focus update is heading to the previous item.
  public static var previous: FocusHeading {
    FocusHeading(rawValue: 1 << 5)
  }
}

/// An object that provides information relevant to a specific focus update from
/// one view to another.
public class FocusUpdateContext {
  // MARK - Locating Focus Direction

  /// The view that was focused before the focus update.
  public private(set) weak var previouslyFocusedView: View?

  /// The view that takes the focus after the focus update.
  public private(set) weak var nextFocusedView: View?

  /// The heading in which the focus update is occurring.
  public private(set) var focusHeading: FocusHeading = .none

  // MARK - Getting Related Focus Items

  /// The item that was focused before the update.
  public private(set) weak var previouslyFocusedItem: FocusItem?

  /// The item to be focused after the update.
  public private(set) weak var nextFocusedItem: FocusItem?

  // MARK - Responding to Focus-Related Keys and Notifications

  /// The focus for the UI has been updated.
  public static var didUpdateNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIFocusUpdateContextDidUpdateNotification")
  }

  /// The focus failed to move to another item.
  public static var movementDidFailNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIFocusUpdateContextMovementDidFailNotification")
  }

  /// Updates the animation coordinator.
  public static var animationCoordinatorUserInfoKey: String {
    "UIFocusUpdateContextAnimationCoordinatorUserInfoKey"
  }

  /// Updates the context key.
  public static var focusUpdateContextUserInfoKey: String {
    "UIFocusUpdateContextFocusUpdateContextUserInfoKey"
  }
}
