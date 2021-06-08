// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

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
