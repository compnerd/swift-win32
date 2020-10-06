/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

internal let IDC_ARROW: UnsafePointer<WCHAR> =
    UnsafePointer<WCHAR>(bitPattern: 32512)!

#if swift(<6.0)
// winreg.h
public let HKEY_CLASSES_ROOT: HKEY = HKEY(bitPattern: 0x80000000)!
public let HKEY_CURRENT_USER: HKEY = HKEY(bitPattern: 0x80000001)!
public let HKEY_LOCAL_MACHINE: HKEY = HKEY(bitPattern: 0x80000002)!
public let HKEY_USERS: HKEY = HKEY(bitPattern: 0x80000003)!
public let HKEY_PERFORMANCE_DATA: HKEY = HKEY(bitPattern: 0x80000004)!
public let HKEY_PERFORMANCE_TEXT: HKEY = HKEY(bitPattern: 0x80000050)!
public let HKEY_PERFORMANCE_NLSTEXT: HKEY = HKEY(bitPattern: 0x80000060)!
public let HKEY_CURRENT_CONFIG: HKEY = HKEY(bitPattern: 0x80000005)!
public let HKEY_DYN_DATA: HKEY = HKEY(bitPattern: 0x80000006)!
public let HKEY_CURRENT_USER_LOCAL_SETTINGS: HKEY = HKEY(bitPattern: 0x80000007)!
#endif

#if swift(<6.0)
// Richedit.h
public let MSFTEDIT_CLASS: String = "RICHEDIT50W"
#endif

// winnt.h
@_transparent
public func MAKELANGID(_ p: WORD, _ s: WORD) -> DWORD {
  return DWORD((s << 10) | p)
}

// WinUser.h
internal let ENUM_CURRENT_SETTINGS: DWORD = DWORD(bitPattern: -1)
internal let HWND_MESSAGE: HWND = HWND(bitPattern: -3)!

internal let GUID_ACDC_POWER_SOURCE: GUID =
    GUID(Data1: 0x5D3E9A59, Data2: 0xE9D5, Data3: 0x4B00,
         Data4: (0xA6, 0xBD, 0xFF, 0x34, 0xFF, 0x51, 0x65, 0x48))
internal let GUID_BATTERY_PERCENTAGE_REMAINING: GUID =
    GUID(Data1: 0xA7AD8041, Data2: 0xB45A, Data3: 0x4CAE,
         Data4: (0x87, 0xA3, 0xEE, 0xCB, 0xB4, 0x68, 0xA9, 0xE1))

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

// Wait next message with timeout
func WaitMessage(_ dwMilliseconds: UINT) -> Bool {
  let timerId = WinSDK.SetTimer(nil, 0, dwMilliseconds, nil)
  defer {
    WinSDK.KillTimer(nil, timerId)
  }
  // returned when a new message is placed in thread's message queue or timer expires
  return WinSDK.WaitMessage()
}
