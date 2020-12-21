// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

extension AlertController {
  /// Constants indicating the type of alert to display.
  public enum Style: Int {
  /// An action sheet displayed in the context of the view controller that
  /// presented it.
  case actionSheet

  /// An alert displayed modally for the app.
  case alert
  }
}

/// An object that displays an alert message to the user.
public class AlertController: ViewController {
  // MARK - Configuring the Alert

  /// Descriptive text that provides more details about the reason for the
  /// alert.
  public var message: String?

  /// The style of the alert controller.
  public let preferredStyle: AlertController.Style

  // MARK - Creating an Alert Controller

  /// Creates and returns a view controller for displaying an alert to the user.
  public init(title: String?, message: String?,
              preferredStyle: AlertController.Style) {
    self.message = message
    self.preferredStyle = preferredStyle
    super.init()
  }

  // MARK - Configuring the User Actions

  /// Attaches an action object to the alert or action sheet.
  public func addAction(_ action: AlertAction) {
  }

  /// The actions that the user can take in response to the alert or action
  /// sheet.
  public private(set) var actions: [AlertAction] = []

  /// The preferred action for the user to take from an alert.
  public var preferredAction: AlertAction?

  // MARK - Configuring Text Fields

  /// Adds a text field to an alert.
  public func addTextField(configurationHandler: ((TextField) -> Void)? = nil) {
  }

  /// The array of text fields displayed by the alert.
  public private(set) var textFields: [TextField]?
}
