// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// An interface for adding and removing menus from a menu system.
public protocol MenuBuilder {
  // MARK - Getting Menu Systems and Elements

  /// The menu system that the menu builder modifies.
  var system: MenuSystem { get }

  /// Gets the menu for the specified menu identifier.
  func menu(for identifier: Menu.Identifier) -> Menu?

  /// Gets the action for the specified action identifier.
  func action(for identifier: Action.Identifier) -> Action?

  /// Gets the command for the specified selector and property list.
  func command(for action: @escaping (_: AnyObject?) -> Void,
               propertyList: Any?) -> Command?

  // MARK - Inserting Child Menus

  /// Adds a child menu as the first element of the specified parent menu.
  func insertChild(_ childMenu: Menu,
                   atStartOfMenu parentIdentifier: Menu.Identifier)

  /// Adds a child menu as the last element of the specified parent menu.
  func insertChild(_ childMenu: Menu,
                   atEndOfMenu parentIdentifier: Menu.Identifier)

  // MARK - Inserting Sibling Menus

  /// Inserts a sibling menu before the specified menu.
  func insertSibling(_ siblingMenu: Menu,
                     beforeMenu siblingIdentifier: Menu.Identifier)

  /// Inserts a sibling menu after the specified menu.
  func insertSibling(_ siblingMenu: Menu,
                     afterMenu siblingIdentifier: Menu.Identifier)

  // MARK - Replacing Menus and Child Menu Elements

  /// Replaces the specified menu with a new menu.
  func replace(menu replacedIdentifier: Menu.Identifier,
               with replacementMenu: Menu)

  /// Replaces the elements in a menu with the elements returned by the
  /// specified handler block.
  func replaceChildren(ofMenu parentIdentifier: Menu.Identifier,
                       from childrenBlock: ([MenuElement]) -> [MenuElement])

  // MARK - Removing a Menu

  /// Removes a menu from the menu system.
  func remove(menu removedIdentifier: Menu.Identifier)
}

extension MenuBuilder {
  func command(for action: @escaping (_: AnyObject?) -> Void,
               propertyList: Any?) -> Command? {
    return nil
  }
}
