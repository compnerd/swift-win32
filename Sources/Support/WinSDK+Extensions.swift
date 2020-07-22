/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

import WinSDK

internal let IDC_ARROW: UnsafePointer<WCHAR> =
    UnsafePointer<WCHAR>(bitPattern: 32512)!

#if swift(<5.3)
// windef.h
internal let DPI_AWARENESS_CONTEXT_UNAWARE: DPI_AWARENESS_CONTEXT =
    DPI_AWARENESS_CONTEXT(bitPattern: -1)!
internal let DPI_AWARENESS_CONTEXT_SYSTEM_AWARE: DPI_AWARENESS_CONTEXT =
    DPI_AWARENESS_CONTEXT(bitPattern: -2)!
internal let DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE: DPI_AWARENESS_CONTEXT =
    DPI_AWARENESS_CONTEXT(bitPattern: -3)!
internal let DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2: DPI_AWARENESS_CONTEXT =
    DPI_AWARENESS_CONTEXT(bitPattern: -4)!
internal let DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED: DPI_AWARENESS_CONTEXT =
    DPI_AWARENESS_CONTEXT(bitPattern: -5)!
#endif

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
