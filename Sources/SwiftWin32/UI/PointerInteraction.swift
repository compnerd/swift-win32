/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// An interaction that enables support for effects on a view or customizes the
/// pointer's appearance within a region of an app.
public class PointerInteraction {
  // MARK - Creating Pointer Interactions

  /// Initializes a pointer interaction object with a specified delegate object.
  public init(delegate: PointerInteractionDelegate?) {
    self.delegate = delegate
  }

  // MARK - Managing Pointer Interactions

  /// An object that responds to pointer movements.
  public private(set) weak var delegate: PointerInteractionDelegate?

  // MARK - Activating Pointer Interactions

  /// A boolean value that indicates whether the pointer interaction is enabled.
  public var isEnabled: Bool = true

  // MARK - Triggering a Pointer Update

  /// Causes the interaction to update the pointer in response to an event.
  public func invalidate() {
  }

  // MARK - Interaction
  public private(set) weak var view: View?
}

extension PointerInteraction: Interaction {
  public func didMove(to view: View?) {
  }

  public func willMove(to view: View?) {
  }
}
