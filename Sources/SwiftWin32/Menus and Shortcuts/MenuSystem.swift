// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// An object representing a main or contextual menu system.
public class MenuSystem {
  // MARK - Getting a Menu System

  /// The main menu system.
  public class var main: MenuSystem {
    fatalError("\(#function) not yet implemented")
  }

  /// The context menu system.
  public class var context: MenuSystem {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Rebuilding a Menu System

  /// Tells the menu system to rebuild all of its menus.
  public func setNeedsRebuild() {
  }

  // MARK - Revalidating a Menu System

  /// Tells the menu system to validate all of its menus.
  public func setNeedsRevalidate() {
  }
}
