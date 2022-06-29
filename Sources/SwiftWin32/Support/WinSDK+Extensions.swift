// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

internal let IDC_ARROW: UnsafePointer<WCHAR> =
    UnsafePointer<WCHAR>(bitPattern: 32512)!

#if swift(<6.0)

// winreg.h
@_transparent
internal var HKEY_CLASSES_ROOT: HKEY? {
  HKEY(bitPattern: 0x80000000)
}

@_transparent
internal var HKEY_CURRENT_USER: HKEY? {
  HKEY(bitPattern: 0x80000001)
}

@_transparent
internal var HKEY_LOCAL_MACHINE: HKEY? {
  HKEY(bitPattern: 0x80000002)
}

@_transparent
internal var HKEY_USERS: HKEY? {
  HKEY(bitPattern: 0x80000003)
}

@_transparent
internal var HKEY_PERFORMANCE_DATA: HKEY? {
  HKEY(bitPattern: 0x80000004)
}

@_transparent
internal var HKEY_PERFORMANCE_TEXT: HKEY? {
  HKEY(bitPattern: 0x80000050)
}

@_transparent
internal var HKEY_PERFORMANCE_NLSTEXT: HKEY? {
  HKEY(bitPattern: 0x80000060)
}

@_transparent
internal var HKEY_CURRENT_CONFIG: HKEY? {
  HKEY(bitPattern: 0x80000005)
}

@_transparent
internal var HKEY_DYN_DATA: HKEY? {
  HKEY(bitPattern: 0x80000006)
}

@_transparent
internal var HKEY_CURRENT_USER_LOCAL_SETTINGS: HKEY? {
  HKEY(bitPattern: 0x80000007)
}

#endif

// Richedit.h
@_transparent
internal var MSFTEDIT_CLASS: String {
  "RICHEDIT50W"
}

// winnt.h

@_transparent
internal func MAKELANGID(_ p: WORD, _ s: WORD) -> DWORD {
  return DWORD((s << 10) | p)
}

@_transparent
internal var GUID_ACDC_POWER_SOURCE: GUID {
  GUID(Data1: 0x5D3E9A59, Data2: 0xE9D5, Data3: 0x4B00,
        Data4: (0xA6, 0xBD, 0xFF, 0x34, 0xFF, 0x51, 0x65, 0x48))
}

@_transparent
internal var GUID_BATTERY_PERCENTAGE_REMAINING: GUID {
  GUID(Data1: 0xA7AD8041, Data2: 0xB45A, Data3: 0x4CAE,
        Data4: (0x87, 0xA3, 0xEE, 0xCB, 0xB4, 0x68, 0xA9, 0xE1))
}

// minwindef.h

@_transparent
internal func LOWORD<T: FixedWidthInteger>(_ dword: T) -> WORD {
  return WORD(DWORD_PTR(dword) >>  0 & 0xffff)
}

@_transparent
internal func HIWORD<T: FixedWidthInteger>(_ dword: T) -> WORD {
  return WORD(DWORD_PTR(dword) >> 16 & 0xffff)
}

// wingdi.h

@_transparent
internal func GetRValue(_ rgb: DWORD) -> DWORD {
  return (rgb >>  0) & 0xff
}

@_transparent
internal func GetGValue(_ rgb: DWORD) -> DWORD {
  return (rgb >>  8) & 0xff
}

@_transparent
internal func GetBValue(_ rgb: DWORD) -> DWORD {
  return (rgb >> 16) & 0xff
}

// WinUser.h

@_transparent
internal var ENUM_CURRENT_SETTINGS: DWORD {
  DWORD(bitPattern: -1)
}

@_transparent
internal var HWND_MESSAGE: HWND {
  HWND(bitPattern: -3)!
}

@_transparent
internal var QS_MOUSE: DWORD {
  DWORD(QS_MOUSEMOVE) | DWORD(QS_MOUSEBUTTON)
}

@_transparent
internal var QS_INPUT: DWORD {
  DWORD(QS_MOUSE) | DWORD(QS_KEY) | DWORD(QS_RAWINPUT) | DWORD(QS_TOUCH) | DWORD(QS_POINTER)
}

@_transparent
internal var QS_ALLEVENTS: DWORD {
  DWORD(QS_INPUT) | DWORD(QS_POSTMESSAGE) | DWORD(QS_TIMER) | DWORD(QS_PAINT) | DWORD(QS_HOTKEY)
}

@_transparent
internal var QS_ALLINPUT: DWORD {
  DWORD(QS_INPUT) | DWORD(QS_POSTMESSAGE) | DWORD(QS_TIMER) | DWORD(QS_PAINT) | DWORD(QS_HOTKEY) | DWORD(QS_SENDMESSAGE)
}

@_transparent
internal var WS_BORDER: DWORD {
  DWORD(WinSDK.WS_BORDER)
}

@_transparent
internal var WS_CAPTION: DWORD {
  DWORD(WinSDK.WS_CAPTION)
}

@_transparent
internal var WS_HSCROLL: DWORD {
  DWORD(WinSDK.WS_HSCROLL)
}

@_transparent
internal var WS_TABSTOP: DWORD {
  DWORD(WinSDK.WS_TABSTOP)
}

@_transparent
internal var WS_VSCROLL: DWORD {
  DWORD(WinSDK.WS_VSCROLL)
}

@_transparent
internal var WS_OVERLAPPEDWINDOW: DWORD {
  DWORD(WinSDK.WS_OVERLAPPEDWINDOW)
}

// `GetMessageW` returns `BOOL` but can return `-1` in the case of an error.
// Explicitly convert the signature to unwrap the `BOOL` to `CInt`.
func GetMessageW(_ lpMsg: LPMSG?, _ hWnd: HWND?, _ wMsgFilterMin: UINT,
                 _ wMsgFilterMax: UINT) -> Bool {
  return WinSDK.GetMessageW(lpMsg, hWnd, wMsgFilterMin, wMsgFilterMax)
}

func GetMessageW(_ lpMsg: LPMSG?, _ hWnd: HWND?, _ wMsgFilterMin: UINT,
                 _ wMsgFilterMax: UINT) -> CInt {
  let pfnGetMessageW: (LPMSG?, HWND?, UINT, UINT) -> CInt =
      unsafeBitCast(WinSDK.GetMessageW,
                    to: ((LPMSG?, HWND?, UINT, UINT) -> CInt).self)
  return pfnGetMessageW(lpMsg, hWnd, wMsgFilterMin, wMsgFilterMax)
}

// `EnableMenuItem` returns `BOOL` but can return `-1` in the case of an error.
// Explicitly convert the signature to unwrap the `BOOL` to `CInt`.
func EnableMenuItem(_ hMenu: HMENU, _ uIDEnableItem: UINT, _ uEnable: UINT)
    -> Bool {
  return WinSDK.EnableMenuItem(hMenu, uIDEnableItem, uEnable)
}

func EnableMenuItem(_ hMenu: HMENU, _ uIDEnableItem: UINT, _ uEnable: UINT)
    -> CInt {
  let pfnEnableMenuItem: (HMENU?, UINT, UINT) -> CInt =
      unsafeBitCast(WinSDK.EnableMenuItem,
                    to: ((HMENU?, UINT, UINT) -> CInt).self)
  return pfnEnableMenuItem(hMenu, uIDEnableItem, uEnable)
}

private func ==<T: Equatable>(_ lhs: (T, T, T, T, T, T, T, T),
                              _ rhs: (T, T, T, T, T, T, T, T)) -> Bool {
  return lhs.0 == rhs.0 &&
         lhs.1 == rhs.1 &&
         lhs.2 == rhs.2 &&
         lhs.3 == rhs.3 &&
         lhs.4 == rhs.4 &&
         lhs.5 == rhs.5 &&
         lhs.6 == rhs.6 &&
         lhs.7 == rhs.7
}

internal func ~=(_ lhs: GUID, _ rhs: GUID) -> Bool {
  return lhs.Data1 == rhs.Data1 &&
         lhs.Data2 == rhs.Data2 &&
         lhs.Data3 == rhs.Data3 &&
         lhs.Data4 == rhs.Data4
}
