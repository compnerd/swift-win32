/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
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

internal let SwiftTextViewProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let textview: TextView? =
      unsafeBitCast(dwRefData, to: AnyObject.self) as? TextView
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

// FIXME(compnerd) we would like this to derive from ScrollView
public class TextView: View {
  public static let `class`: WindowClass = WindowClass(named: "EDIT")
  public static let style: WindowStyle =
      WindowStyle(base: DWORD(WS_BORDER | WS_HSCROLL | WS_TABSTOP | WS_VISIBLE | WS_VSCROLL | ES_MULTILINE),
                  extended: 0)

  public var editable: Bool {
    get {
      GetWindowLongW(hWnd, GWL_STYLE) & ES_READONLY == ES_READONLY
    }
    set(editable) {
      SendMessageW(hWnd, UINT(EM_SETREADONLY), editable ? 0 : 1, 0)
    }
  }

  public var font: Font? {
    get {
      let lResult: LRESULT = SendMessageW(hWnd, UINT(WM_GETFONT), 0, 0)
      return Font(UnownedFontHandle(hFont: HFONT(bitPattern: Int(lResult))))
    }
    set(font) {
      SendMessageW(hWnd, UINT(WM_SETFONT),
                   unsafeBitCast(font?.hFont.value, to: WPARAM.self), LPARAM(1))
    }
  }

  public var text: String? {
    get {
      let szLength: Int32 = GetWindowTextLengthW(hWnd)

      let buffer: UnsafeMutablePointer<WCHAR> =
        UnsafeMutablePointer<WCHAR>.allocate(capacity: Int(szLength) + 1)
      defer { buffer.deallocate() }

      GetWindowTextW(hWnd, buffer, szLength + 1)
      return String(decodingCString: buffer, as: UTF16.self)
    }
    set(value) {
      SetWindowTextW(hWnd, value?.LPCWSTR)
    }
  }

  public override init(frame: Rect = .default, `class`: WindowClass = TextView.class,
                       style: WindowStyle = TextView.style) {
    super.init(frame: frame, class: `class`, style: style)
    SetWindowSubclass(hWnd, SwiftTextViewProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  public func scrollRangeToVisible(_ range: Range) {
    SendMessageW(hWnd, UINT(EM_SETSEL), WPARAM(range.location),
                 LPARAM(range.location + range.length))
    SendMessageW(hWnd, UINT(EM_SETSEL), UInt64(bitPattern: -1), -1)
    SendMessageW(hWnd, UINT(EM_SCROLLCARET), 0, 0)
  }
}
