/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import Foundation

private let SwiftTextViewProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
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
      self.GWL_STYLE & ES_READONLY == ES_READONLY
    }
    set(editable) {
      SendMessageW(hWnd, UINT(EM_SETREADONLY), editable ? 0 : 1, 0)
    }
  }

  public override var font: Font? {
    get { return super.font }
    set(value) { super.font = value }
  }

  @_Win32WindowText
  public var text: String?

  public init(frame: Rect) {
    super.init(frame: frame, class: TextView.class, style: TextView.style)

    // Remove the `WS_EX_CLIENTEDGE` which gives it a flat appearance
    self.GWL_EXSTYLE &= ~WS_EX_CLIENTEDGE
    _ = SetWindowSubclass(hWnd, SwiftTextViewProc, UINT_PTR(1),
                          unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  public func scrollRangeToVisible(_ range: NSRange) {
    SendMessageW(hWnd, UINT(EM_SETSEL), WPARAM(range.location),
                 LPARAM(range.location + range.length))
    SendMessageW(hWnd, UINT(EM_SETSEL), UInt64(bitPattern: -1), -1)
    SendMessageW(hWnd, UINT(EM_SCROLLCARET), 0, 0)
  }
}
