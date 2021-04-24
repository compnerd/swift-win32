// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

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
  public internal(set) var title: String

  /// The image to display alongside the menu element's title.
  public internal(set) var image: Image?

  /// Creating a Menu Element

  public init(title: String, image: Image? = nil) {
    self.title = title
    self.image = image
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
