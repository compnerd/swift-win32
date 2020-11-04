/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

private let SwiftSwitchProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let button: Switch? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Switch
  switch uMsg {
  default:
    break
  }
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Switch: Control {
  private static let `class`: WindowClass = WindowClass(named: WC_BUTTON)
  private static let style: WindowStyle =
      (base: DWORD(WS_TABSTOP | BS_AUTOCHECKBOX), extended: 0)

  /// Customizing the Appearance of the Switch
  @_Win32WindowText
  public var title: String?

  /// Customizing the Style
  public var preferredStyle: Switch.Style = .automatic {
    didSet { fatalError("not yet implemented") }
  }
  public private(set) var style: Switch.Style = .checkbox

  /// Setting the Off/On State
  public var isOn: Bool {
    get { SendMessageW(self.hWnd, UINT(BM_GETCHECK), 0, 0) == BST_CHECKED }
    set(value) { self.setOn(value, animated: false) }
  }

  public func setOn(_ on: Bool, animated: Bool) {
    assert(!animated, "not yet implemented")
    _ = SendMessageW(self.hWnd, UINT(BM_SETCHECK), WPARAM(on ? 1 : 0), 0)
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: Switch.class, style: Switch.style)
    SetWindowSubclass(hWnd, SwiftSwitchProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }
}

extension Switch {
  public enum Style: Int {
  case automatic
  case checkbox
  case sliding
  }
}
