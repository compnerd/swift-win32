// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The set of actions to perform when swiping on rows of a table.
public class SwipeActionsConfiguration {
  // MARK - Initializing the Swipe Actions

  /// Creates a swipe action configuration object with the specified set of
  /// actions.
  public init(actions: [ContextualAction]) {
  // convenience
    self.actions = actions
  }

  // MARK - Getting the Swipe Action Information

  /// The swipe actions.
  public private(set) var actions: [ContextualAction]

  /// A boolean value indicating whether a full swipe automatically performs the
  /// first action.
  public var performsFirstActionWithFullSwipe: Bool = true
}
