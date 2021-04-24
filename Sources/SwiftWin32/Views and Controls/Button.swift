// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

private let SwiftButtonProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let button: Button? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Button

  switch uMsg {
  case UINT(WM_LBUTTONUP):
    button?.sendActions(for: .primaryActionTriggered)
  default:
    break
  }

  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}


public class Button: Control {
  private static let `class`: WindowClass = WindowClass(named: WC_BUTTON)
  // MSDN:
  // A button sends the `BN_DISABLE`, `BN_PUSHED`, `BN_KILLFOCUS`, `BN_PAINT`,
  // `BN_SETFOCUS`, and `BN_UNPUSHED` notification codes only if it has the
  // `BS_NOFITY` style.
  private static let style: WindowStyle =
      (base: WS_TABSTOP | DWORD(BS_MULTILINE | BS_NOTIFY | BS_PUSHBUTTON),
       extended: 0)

  public init(frame: Rect) {
    super.init(frame: frame, class: Button.class, style: Button.style)

    _ = SetWindowSubclass(hWnd, SwiftButtonProc, UINT_PTR(1),
                          unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  // FIXME(compnerd) handle title setting for different states
  public func setTitle(_ title: String?, forState _: Control.State) {
    SetWindowTextW(hWnd, title?.wide)
  }
}
