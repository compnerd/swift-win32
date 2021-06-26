// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// An object representing a main or contextual menu system.
open class MenuSystem {
  // MARK - Getting a Menu System

  /// The main menu system.
  open class var main: MenuSystem {
    fatalError("\(#function) not yet implemented")
  }

  /// The context menu system.
  open class var context: MenuSystem {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Rebuilding a Menu System

  /// Tells the menu system to rebuild all of its menus.
  open func setNeedsRebuild() {
  }

  // MARK - Revalidating a Menu System

  /// Tells the menu system to validate all of its menus.
  open func setNeedsRevalidate() {
  }
}
