/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
