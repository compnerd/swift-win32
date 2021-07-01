// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

@_implementationOnly
import OrderedCollections

internal final class _MenuBuilder: MenuSystem {
  internal private(set) var hMenu: MenuHandle
  internal private(set) weak var view: View?

  private var menus: OrderedSet<Menu>

  internal init?(for view: View) {
    self.hMenu = MenuHandle(owning: CreateMenu())
    if self.hMenu.value == nil {
      log.warning("CreateMenu: \(Error(win32: GetLastError()))")
      return nil
    }
    self.view = view
    self.menus = []
  }

  override func setNeedsRebuild() {
    // TODO(compnerd) create the actual menus
  }
}

extension _MenuBuilder: MenuBuilder {
  public var system: MenuSystem {
    return self
  }

  public func menu(for identifier: Menu.Identifier) -> Menu? {
    self.menus.first { $0.identifier == identifier }
  }

  public func action(for identifier: Action.Identifier) -> Action? {
    return nil
  }

  public func insertChild(_ menu: Menu,
                          atStartOfMenu identifier: Menu.Identifier) {
    // FIXME(compnerd) what happens if the element is not found?
    if let index = self.menus.firstIndex(where: { $0.identifier == identifier }) {
      let parent = self.menus[index]
      parent.children.insert(menu, at: parent.children.startIndex)
    }
  }

  public func insertChild(_ menu: Menu,
                          atEndOfMenu identifier: Menu.Identifier) {
    // FIXME(compnerd) what happens if the element is not found?
    if let index = self.menus.firstIndex(where: { $0.identifier == identifier }) {
      let parent = self.menus[index]
      parent.children.insert(menu, at: parent.children.endIndex)
    }
  }

  public func insertSibling(_ menu: Menu,
                            beforeMenu identifier: Menu.Identifier) {
    let index: OrderedSet<Menu>.Index =
      identifier == .root
          ? self.menus.startIndex
          : self.menus.firstIndex { $0.identifier == identifier } ?? self.menus.startIndex
    self.menus.insert(menu, at: index)
  }

  public func insertSibling(_ menu: Menu,
                            afterMenu identifier: Menu.Identifier) {
    let index: OrderedSet<Menu>.Index =
        identifier == .root
            ? self.menus.endIndex
            : self.menus.firstIndex { $0.identifier == identifier } ?? self.menus.endIndex
    self.menus.insert(menu, at: index)
  }

  public func replace(menu identifier: Menu.Identifier, with menu: Menu) {
    // FIXME(compnerd) should we be appending the item if the specified
    // identifier is not found?
    if let index = self.menus.firstIndex(where: { $0.identifier == identifier }) {
      _ = self.menus.remove(at: index)
      self.menus.insert(menu, at: index)
    }
  }

  public func replaceChildren(ofMenu parentIdentifier: Menu.Identifier,
                              from childrenBlock: ([MenuElement]) -> [MenuElement]) {
  }

  public func remove(menu identifier: Menu.Identifier) {
    // FIXME(compnerd) what happens if the element is not found?
    if let index = self.menus.firstIndex(where: { $0.identifier == identifier }) {
      _ = self.menus.remove(at: index)
    }
  }
}
