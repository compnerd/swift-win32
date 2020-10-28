/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

extension HFONT__: HandleValue {
  typealias HandleType = HFONT
  internal static func release(_ hFont: HandleType?) {
    if let hFont = hFont {
      DeleteObject(hFont)
    }
  }
}

internal typealias FontHandle = ManagedHandle<HFONT__>

extension HDC__: HandleValue {
  typealias HandleType = HDC
  internal static func release(_ hDC: HandleType?) {
    if let hDC = hDC {
      DeleteDC(hDC)
    }
  }
}

internal typealias DeviceContextHandle = ManagedHandle<HDC__>

extension HBITMAP__: HandleValue {
  typealias HandleType = HBITMAP
  internal static func release(_ hBitmap: HandleType?) {
    if let hBitmap = hBitmap {
      DeleteObject(hBitmap)
    }
  }
}
internal typealias BitmapHandle = ManagedHandle<HBITMAP__>

extension HMENU: HandleValue {
  typealias HandleType = HMENU
  internal static func release(_ hMenu: HandleType?) {
    if let hMenu = hMenu {
      DestroyMenu(hMenu)
    }
  }
}

internal typealias MenuHandle = ManagedHandle<HMENU>
