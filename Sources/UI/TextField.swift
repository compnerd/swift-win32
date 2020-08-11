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

public protocol TextFieldDelegate: class {
}

private let SwiftTextFieldProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let textfield: TextField! =
      unsafeBitCast(dwRefData, to: AnyObject.self) as? TextField

  switch uMsg {
  case UINT(WM_PAINT):
    guard let placeholder = textfield.placeholder, textfield.text == nil else {
      break
    }

    // Get the device context with DCX_INTERSECTUPDATE before the default
    // WM_PAINT event handler calls `BeginPaint`/`EndPaint` which invalidates
    // the update rect and will nullify the rendering as the region is empty.
    // Gerab the value from the cache to avoid interacting with the control's
    // DC.
    let hDC: HDC =
        GetDCEx(hWnd, nil, DWORD(DCX_INTERSECTUPDATE | DCX_CACHE | DCX_CLIPCHILDREN | DCX_CLIPSIBLINGS))

    // Invoke the default renderer
    let lResult: LRESULT = DefSubclassProc(hWnd, uMsg, wParam, lParam)

    // Get the Client Rect
    var rctClient: RECT = RECT()
    _ = withUnsafeMutablePointer(to: &rctClient) {
      SendMessageW(hWnd, UINT(EM_GETRECT), 0,
                   LPARAM(bitPattern: UInt64(Int(bitPattern: $0))))
    }

    _ = SetTextColor(hDC, GetSysColor(COLOR_GRAYTEXT))
    _ = SetBkMode(hDC, TRANSPARENT)
    _ = DrawTextW(hDC, placeholder.LPCWSTR, -1, &rctClient,
                  UINT(DT_EDITCONTROL | DT_NOCLIP | DT_NOPREFIX | DT_SINGLELINE | DT_VCENTER))

    _ = ReleaseDC(hWnd, hDC)

    return lResult
  default:
    break
  }

  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public enum TextAlignment: Int {
case natural
case left
case right
case center
case justified
}

public class TextField: Control {
  private static let `class`: WindowClass = WindowClass(named: MSFTEDIT_CLASS)
  private static let style: WindowStyle =
      (base: DWORD(WS_BORDER) | WS_POPUP | DWORD(WS_TABSTOP | ES_AUTOHSCROLL),
       extended: 0)

  public weak var delegate: TextFieldDelegate?

  /// Accessing the Text Attributes
  @_Win32WindowText
  public var text: String?

  public var placeholder: String?

  public override var font: Font? {
    get { return super.font }
    set(value) { super.font = value }
  }

  public var textAlignment: TextAlignment {
    get {
      var pfFormat: PARAFORMAT = PARAFORMAT()
      pfFormat.cbSize = UINT(MemoryLayout<PARAFORMAT>.size)
      pfFormat.dwMask = DWORD(PFM_ALIGNMENT)

      _ = withUnsafePointer(to: &pfFormat) {
        SendMessageW(hWnd, UINT(EM_GETPARAFORMAT), 0, LPARAM(Int(bitPattern: $0)))
      }

      switch pfFormat.wAlignment {
      case WORD(PFA_LEFT):
        return .left
      case WORD(PFA_RIGHT):
        return .right
      case WORD(PFA_CENTER):
        return .center
      case WORD(PFA_JUSTIFY):
        return .justified
      default:
        fatalError("unknown alignment `\(pfFormat.wAlignment)`")
      }
    }
    set(value) {
      var pfFormat: PARAFORMAT = PARAFORMAT()
      pfFormat.cbSize = UINT(MemoryLayout<PARAFORMAT>.size)
      pfFormat.dwMask = DWORD(PFM_ALIGNMENT)

      switch value {
      case .natural:
        fatalError("do not know how to render `\(value)` text")
      case .left:
        pfFormat.wAlignment = WORD(PFA_LEFT)
      case .right:
        pfFormat.wAlignment = WORD(PFA_RIGHT)
      case .center:
        pfFormat.wAlignment = WORD(PFA_CENTER)
      case .justified:
        pfFormat.wAlignment = WORD(PFA_JUSTIFY)
      }

      _ = withUnsafePointer(to: &pfFormat) {
        SendMessageW(hWnd, UINT(EM_SETPARAFORMAT), 0, LPARAM(Int(bitPattern: $0)))
      }
    }
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: TextField.class, style: TextField.style)

    // Remove the `WS_EX_CLIENTEDGE` which gives it a flat appearance
    let lExtendedStyle: LONG = GetWindowLongW(self.hWnd, GWL_EXSTYLE);
    _ = SetWindowLongW(self.hWnd, GWL_EXSTYLE,
                       lExtendedStyle & ~WS_EX_CLIENTEDGE)

    // Enable the advanced typography options unconditionally rather than only
    // in complex scripts and math mode.
    SendMessageW(self.hWnd, UINT(EM_SETTYPOGRAPHYOPTIONS),
                 WPARAM(TO_ADVANCEDTYPOGRAPHY), LPARAM(TO_ADVANCEDTYPOGRAPHY))

    SetWindowSubclass(self.hWnd, SwiftTextFieldProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }
}

extension TextField: TextInputTraits {
  public var isSecureTextEntry: Bool {
    get {
      SendMessageW(self.hWnd, UINT(EM_GETPASSWORDCHAR), 0, 0) == 0
          ? false
          : true
    }
    set {
      // 0x25cf is "BLACK CIRCLE"
      _ = SendMessageW(self.hWnd, UINT(EM_SETPASSWORDCHAR),
                       WPARAM(newValue ? 0x25cf : 0), 0)
    }
  }
}
