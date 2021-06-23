// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

extension ContextMenuInteraction {
  /// Constants that describe the appearance of the menu.
  public enum Appearance: Int {
    /// No menu appearance.
    case unknown

    /// A modal menu with an optional preview.
    case rich

    /// A nonmodal, compact menu with no preview.
    case compact
  }
}

/// An interaction object that you use to display relevant actions for your
/// content.
public class ContextMenuInteraction: Interaction {
  // MARK - Creating a Context Menu Interaction Object

  /// Creates a context menu interaction object with the specified delegate
  /// object.
  public init(delegate: ContextMenuInteractionDelegate) {
    self.delegate = delegate
  }

  // MARK - Previewing and Managing the Content

  /// The object that provides the preview and contextual menu for your content
  /// and responds to interaction-related events.
  public private(set) weak var delegate: ContextMenuInteractionDelegate?

  public private(set) weak var view: View?

  public func willMove(to view: View?) {
  }

  public func didMove(to view: View?) {
    self.view = view
  }

  // MARK - Getting the Interaction's Location

  /// Returns the location of the user interaction in the specified view's
  /// coordinate system.
  public func location(in view: View?) -> Point {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Getting the Menu Appearance

  /// The appearance of the context menu.
  public var appearance: ContextMenuInteraction.Appearance = .compact

  // MARK - Managing Menu Interactions

  /// Dismisses the context menu.
  public func dismissMenu() {
  }

  /// Updates the currently visible menu.
  public func updateVisibleMenu(_ block: (Menu) -> Menu) {
  }
}
