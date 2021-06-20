// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

@_implementationOnly
import OrderedCollections

internal struct Win32Menu {
  internal let hMenu: MenuHandle

  private let items: [Win32MenuElement]

  internal init(_ hMenu: MenuHandle, items: [MenuElement]) {
    self.hMenu = hMenu
    self.items = items.map { Win32MenuElement($0) }
    for (index, child) in self.items.enumerated() {
      InsertMenuItemW(hMenu.value, UINT(index), true, &child.info)
    }
  }
}

internal class Win32MenuElement {
  private var title: [WCHAR]
  private let submenu: Win32Menu?
  private let image: BitmapHandle?

  internal var info: MENUITEMINFOW

  private init(title: String, image: Image?, submenu: Win32Menu?, fType: Int32) {
    self.title = title.wide
    self.submenu = submenu

    let imageHandle: BitmapHandle?
    if let bitmap = image?.bitmap {
      imageHandle = BitmapHandle(from: bitmap)
    } else {
      imageHandle = nil
    }
    self.image = imageHandle

    self.info = self.title.withUnsafeMutableBufferPointer {
      MENUITEMINFOW(cbSize: UINT(MemoryLayout<MENUITEMINFOW>.size),
                    fMask: UINT(MIIM_FTYPE | MIIM_STATE | MIIM_ID | MIIM_STRING | MIIM_SUBMENU | MIIM_DATA | MIIM_BITMAP),
                    fType: UINT(fType),
                    fState: UINT(MFS_ENABLED),
                    wID: UInt32.random(in: .min ... .max),
                    hSubMenu: submenu?.hMenu.value,
                    hbmpChecked: nil,
                    hbmpUnchecked: nil,
                    dwItemData: 0,
                    dwTypeData: $0.baseAddress,
                    cch: UINT(title.count),
                    hbmpItem: imageHandle?.value)
    }
  }

  internal convenience init(_ element: MenuElement) {
    if let menu = element as? Menu {
      self.init(title: element.title,
                image: element.image,
                submenu: Win32Menu(MenuHandle(owning: CreatePopupMenu()),
                                   items: menu.children),
                fType: MFT_STRING)
    } else {
      self.init(title: element.title, image: element.image, submenu: nil, fType: MFT_STRING)
    }
  }
}

extension Win32MenuElement {
  internal static var separator: Win32MenuElement {
    Win32MenuElement(title: "", image: nil, submenu: nil, fType: MFT_SEPARATOR)
  }

  internal var isSeparator: Bool {
    info.fType == MFT_SEPARATOR
  }
}

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
