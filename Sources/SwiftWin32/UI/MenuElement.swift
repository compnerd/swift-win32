/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

extension MenuElement {
  /// Attributes that determine the style of the menu element.
  public struct Attributes: OptionSet {
    public typealias RawValue = Int

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension MenuElement.Attributes {
  /// An attribute indicating the destructive style.
  public static var destructive: MenuElement.Attributes {
    MenuElement.Attributes(rawValue: 1 << 1)
  }

  /// An attribute indicating the disabled style.
  public static var disabled: MenuElement.Attributes {
    MenuElement.Attributes(rawValue: 1 << 0)
  }

  /// An attribute indicating the hidden style.
  public static var hidden: MenuElement.Attributes {
    MenuElement.Attributes(rawValue: 1 << 2)
  }
}

extension MenuElement {
  /// Constants that indicate the state of an action-based or command-based
  /// menu element.
  public enum State: Int {
  /// A constant indicating the menu element is in the "off" state.
  case off

  /// A constant indicating the menu element is in the "on" state.
  case on

  /// A constant indicating the menu element is in the "mixed" state.
  case mixed
  }
}

/// An object representing a menu, action, or command.
public class MenuElement {
  /// Getting the Element Attributes

  /// The title of the menu element.
  public let title: String

  /// The image to display alongside the menu element's title.
  public let image: Image?

  /// Creating a Menu Element

  public init(title: String, image: Image? = nil) {
    self.title = title
    self.image = image
  }
}

internal class Win32MenuElement {
  internal var info: MENUITEMINFOW
  private var titleW: [WCHAR]
  private let subMenu: Win32Menu?

  private init(title: String, subMenu: Win32Menu?, fType: Int32) {
    self.titleW = title.LPCWSTR
    let titleSize = titleW.count

    self.subMenu = subMenu
    self.info = titleW.withUnsafeMutableBufferPointer {
      MENUITEMINFOW(cbSize: UINT(MemoryLayout<MENUITEMINFOW>.size),
                    fMask: UINT(MIIM_FTYPE | MIIM_STATE | MIIM_ID | MIIM_STRING | MIIM_SUBMENU | MIIM_DATA),
                    fType: UINT(fType),
                    fState: UINT(MFS_ENABLED),
                    wID: UInt32.random(in: .min ... .max),
                    hSubMenu: subMenu?.hMenu.value,
                    hbmpChecked: nil,
                    hbmpUnchecked: nil,
                    dwItemData: 0,
                    dwTypeData: $0.baseAddress,
                    cch: UINT(titleSize),
                    hbmpItem: nil)
    }
  }

  internal static func of(_ element: MenuElement) -> Win32MenuElement {
    let subMenu: Win32Menu?
    if let menu = element as? Menu {
      subMenu = Win32Menu(MenuHandle(owning: CreatePopupMenu()),
                          children: menu.children)
    } else {
      subMenu = nil
    }
    return Win32MenuElement(title: element.title, subMenu: subMenu, fType: MFT_STRING)
  }

  internal static var separator: Win32MenuElement {
    Win32MenuElement(title: "", subMenu: nil, fType: MFT_SEPARATOR)
  }

  internal var isSeparator: Bool {
    info.fType == MFT_SEPARATOR
  }
}
