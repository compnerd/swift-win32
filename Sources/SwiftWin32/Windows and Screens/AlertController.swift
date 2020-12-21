/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

extension AlertController {
  /// Constants indicating the type of alert to display.
  public enum Style: Int {
  case actionSheet
  case alert
  }
}

public class AlertController: ViewController {
  /// Configuring the Alert
  public var message: String?
  public let preferredStyle: AlertController.Style

  /// Creating an Alert Controller
  public init(title: String?, message: String?,
              preferredStyle: AlertController.Style) {
    self.message = message
    self.preferredStyle = preferredStyle
    super.init()
  }

  /// Configuring the User Actions

  /// The actions that the user can take in response to the alert or action
  /// sheet.
  public private(set) var actions: [AlertAction] = []

  /// The preferred action for the user to take from an alert.
  public var preferredAction: AlertAction?

  /// Attaches an action object to the alert or action sheet.
  public func addAction(_ action: AlertAction) {
  }

  /// Configuring Text Fields

  /// The array of text fields displayed by the alert.
  public private(set) var textFields: [TextField]?

  /// Adds a text field to an alert.
  public func addTextField(configurationHandler: ((TextField) -> Void)? = nil) {
  }
}
