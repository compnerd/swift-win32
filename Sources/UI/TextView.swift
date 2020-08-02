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
import Foundation

internal let SwiftTextViewProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let textview: TextView? =
      unsafeBitCast(dwRefData, to: AnyObject.self) as? TextView
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

// FIXME(compnerd) we would like this to derive from ScrollView
public class TextView: View {
  private static let `class`: WindowClass = WindowClass(named: MSFTEDIT_CLASS)
  private static let style: WindowStyle =
      (base: DWORD(WS_BORDER | WS_HSCROLL) | WS_POPUP | DWORD(WS_TABSTOP | WS_VSCROLL | ES_MULTILINE),
       extended: 0)

  public var editable: Bool {
    get {
      GetWindowLongW(hWnd, GWL_STYLE) & ES_READONLY == ES_READONLY
    }
    set(editable) {
      SendMessageW(hWnd, UINT(EM_SETREADONLY), editable ? 0 : 1, 0)
    }
  }

  @_Win32Font
  public var font: Font?

  @_Win32WindowText
  public var text: String?

  public init(frame: Rect = .default) {
    super.init(frame: frame, class: TextView.class, style: TextView.style)

    // Remove the `WS_EX_CLIENTEDGE` which gives it a flat appearance
    let lExtendedStyle: LONG = GetWindowLongW(hWnd, GWL_EXSTYLE);
    SetWindowLongW(hWnd, GWL_EXSTYLE, lExtendedStyle & ~WS_EX_CLIENTEDGE)

    SetWindowSubclass(hWnd, SwiftTextViewProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  public func scrollRangeToVisible(_ range: NSRange) {
    SendMessageW(hWnd, UINT(EM_SETSEL), WPARAM(range.location),
                 LPARAM(range.location + range.length))
    SendMessageW(hWnd, UINT(EM_SETSEL), UInt64(bitPattern: -1), -1)
    SendMessageW(hWnd, UINT(EM_SCROLLCARET), 0, 0)
  }
}
