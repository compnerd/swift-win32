/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import class Foundation.NSUUID
import protocol Foundation.NSCopying

public class ContextMenuConfiguration {
  /// Creating the Menu Configuration Object

  /// Returns the custom view controller to use when previewing your content.
  public typealias ContextMenuContentPreviewProvider = () -> ViewController?

  /// Returns an action-based contextual menu, optionally incorporating the
  /// system-suggested actions.
  public typealias ContextMenuActionProvider = ([MenuElement]) -> Menu?

  /// Creates a menu configuration object with the specified action and preview
  /// providers.
  public convenience init(identifier: NSCopying?,
                          previewProvider: ContextMenuContentPreviewProvider?,
                          actionProvider: ContextMenuActionProvider? = nil) {
    // TODO(compnerd) fill out the default preview provider
    self.init(identifier: identifier ?? NSUUID(),
              previewProvider: previewProvider ?? { return nil },
              actionProvider: actionProvider)
  }

  private init(identifier: NSCopying,
               previewProvider: @escaping ContextMenuContentPreviewProvider,
               actionProvider: ContextMenuActionProvider?) {
    self.identifier = identifier
    self.previewProvider = previewProvider
    self.actionProvider = actionProvider
  }

  /// Getting the Configuration Identifier

  /// The unique identifier for this configuration object.
  public let identifier: NSCopying

  private var previewProvider: ContextMenuContentPreviewProvider
  private var actionProvider: ContextMenuActionProvider?

  internal func provideActions() -> Menu? {
    actionProvider?([]) // TODO suggest default actions
  }
}
