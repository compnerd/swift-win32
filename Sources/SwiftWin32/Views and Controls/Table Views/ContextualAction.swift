// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

extension ContextualAction {
  /// Constants indicating the style information that is applied to the action
  /// button.
  public enum Style: Int {
  /// A normal action.
  case normal

  /// An action that deletes data or performs some type of destructive task.
  case destructive
  }
}

/// An action to display when the user swipes a table row.
public class ContextualAction {
  // MARK - Creating the Contexual Action

  /// Creates a new contextual action with the specified title and handler.
  public /*convenience*/ init(style: ContextualAction.Style, title: String?,
                              handler: @escaping ContextualAction.Handler) {
    self.title = title
    self.handler = handler
    self.style = style

    // XXX(compnerd) should this be stylized from a global?
    switch style {
    case .normal:
      // FIXME(compnerd) should this be `.clear`?
      self.backgroundColor = Color(color: GetSysColor(COLOR_3DFACE))
    case .destructive:
      self.backgroundColor = .red
    }
  }

  // MARK - Configuring the Appearance

  /// The title displayed on the action button.
  public var title: String?

  /// The background color of the action button.
  public let backgroundColor: Color!

  /// The image to display in the action button.
  public var image: Image?

  // MARK - Getting the Configuration Details

  /// The handler block to execute when the user selects the action.
  public let handler: ContextualAction.Handler

  /// The handler block to call in response to the selection of an action.
  public typealias Handler =
      (ContextualAction, View, @escaping (Bool) -> Void) -> Void

  /// The style that is applied to the action button.
  public let style: ContextualAction.Style
}
