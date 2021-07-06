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
    self.hMenu = MenuHandle(owning: view is Window ? CreateMenu() : CreatePopupMenu())
    if self.hMenu.value == nil {
      log.warning("CreateMenu: \(Error(win32: GetLastError()))")
      return nil
    }
    self.view = view
    self.menus = []
  }

  private func append<T: Collection>(_ menus: T, to hMenu: MenuHandle)
      where T.Element: MenuElement {
    for (index, child) in menus.enumerated() {
      let hImage: BitmapHandle? =
          BitmapHandle(from: child.image?.bitmap)

      var hSubmenu: MenuHandle?
      if let submenu = child as? Menu {
        hSubmenu = MenuHandle(referencing: CreatePopupMenu())
        if hSubmenu?.value == nil {
          log.warning("CreateMenu: \(Error(win32: GetLastError()))")
          continue
        }
        append(submenu.children, to: hSubmenu!)
      }

      var wide = child.title.wide
      var info = wide.withUnsafeMutableBufferPointer {
        MENUITEMINFOW(cbSize: UINT(MemoryLayout<MENUITEMINFOW>.size),
                      fMask: UINT(MIIM_FTYPE | MIIM_STATE | MIIM_ID | MIIM_STRING | MIIM_SUBMENU | MIIM_DATA | MIIM_BITMAP),
                      fType: UINT(MFT_STRING), fState: UINT(MFS_ENABLED), wID: UInt32.random(in: .min ... .max),
                      hSubMenu: hSubmenu?.value, hbmpChecked: nil, hbmpUnchecked: nil, dwItemData: 0,
                      dwTypeData: $0.baseAddress, cch: UINT(child.title.count), hbmpItem: hImage?.value)
      }
      InsertMenuItemW(hMenu.value, UINT(index), true, &info)
    }
  }

  override func setNeedsRebuild() {
    // Remove the old submenus from the menu:
    for index in (0..<GetMenuItemCount(self.hMenu.value)).reversed() {
      DeleteMenu(self.hMenu.value, UINT(index), UINT(MF_BYPOSITION))
    }

    // Create the new submenus and add them to the root menu:
    append(self.menus, to: self.hMenu)

    if let window = view as? Window {
      window.hWindowMenu = self.hMenu
      SetMenu(window.hWnd, window.hWindowMenu?.value)
    }
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
