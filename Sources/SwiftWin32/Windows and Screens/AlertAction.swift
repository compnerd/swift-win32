// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

extension AlertAction {
  /// Styles to apply to action buttons in an alert.
  public enum Style: Int {
    /// Apply the default style to the action’s button.
    case `default`

    /// Apply a style that indicates the action cancels the operation and leaves
    /// things unchanged.
    case cancel

    /// Apply a style that indicates the action might change or delete data.
    case destructive
  }
}

/// An action that can be taken when the user taps a button in an alert.
public class AlertAction {
  private let handler: ((AlertAction) -> Void)?

  // MARK - Creating an Alert Action

  /// Create and return an action with the specified title and behavior.
  public init(title: String?, style: AlertAction.Style,
              handler: ((AlertAction) -> Void)? = nil) {
    self.title = title
    self.style = style
    self.isEnabled = true
    self.handler = handler
  }

  // MARK - Getting the Action's Attributes

  /// The title of the action’s button.
  public let title: String?

  /// The style that is applied to the action’s button.
  public let style: AlertAction.Style

  /// A Boolean value indicating whether the action is currently enabled.
  public var isEnabled: Bool
}
