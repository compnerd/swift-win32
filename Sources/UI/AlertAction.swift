/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

extension AlertAction {
  public enum Style: Int {
  case `default`
  case cancel
  case destructive
  }
}

public class AlertAction {
  private let handler: ((AlertAction) -> Void)?

  /// Creating an Alert Action

  /// Create and return an action with the specified title and behavior.
  public init(title: String?, style: AlertAction.Style,
              handler: ((AlertAction) -> Void)? = nil) {
    self.title = title
    self.style = style
    self.isEnabled = true
    self.handler = handler
  }

  /// Getting the Action's Attributes

  /// The title of the action’s button.
  public let title: String?

  /// The style that is applied to the action’s button.
  public let style: AlertAction.Style

  /// A Boolean value indicating whether the action is currently enabled.
  public var isEnabled: Bool
}
