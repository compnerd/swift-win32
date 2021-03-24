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

/// A control that offers a binary choice, such as on/off.
public class Switch: Control {
  private static let `class`: WindowClass = WindowClass(named: WC_BUTTON)
  // MSDN:
  // A button sends the `BN_DISABLE`, `BN_PUSHED`, `BN_KILLFOCUS`, `BN_PAINT`,
  // `BN_SETFOCUS`, and `BN_UNPUSHED` notification codes only if it has the
  // `BS_NOFITY` style.
  private static let style: WindowStyle =
      (base: WS_TABSTOP | DWORD(BS_AUTOCHECKBOX | BS_NOTIFY), extended: 0)

  // MARK - Setting the Off/On State

  /// A Boolean value that determines the off/on state of the switch.
  public var isOn: Bool {
    get { SendMessageW(self.hWnd, UINT(BM_GETCHECK), 0, 0) == BST_CHECKED }
    set(value) { self.setOn(value, animated: false) }
  }

  /// Set the state of the switch to On or Off, optionally animating the
  /// transition.
  public func setOn(_ on: Bool, animated: Bool) {
    assert(!animated, "not yet implemented")
    _ = SendMessageW(self.hWnd, UINT(BM_SETCHECK), WPARAM(on ? 1 : 0), 0)
  }

  // MARK - Setting the Display Style

  /// The preferred display style for the switch.
  public var preferredStyle: Switch.Style = .automatic {
    didSet { fatalError("not yet implemented") }
  }

  /// The display style for the switch.
  public private(set) var style: Switch.Style = .checkbox

  /// The title displayed next to a checkbox-style switch.
  @_Win32WindowText
  public var title: String?

  // MARK - Initializing the Switch Object

  /// Returns an initialized switch object.
  public init(frame: Rect) {
    super.init(frame: frame, class: Switch.class, style: Switch.style)
    SetWindowSubclass(hWnd, SwiftSwitchProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }
}

extension Switch {
  /// Styles that determine the appearance of the switch.
  public enum Style: Int {
  /// A style indicating that the system chooses the appearance of the switch
  /// according to the current user interface idiom.
  case automatic

  /// A style indicating that the switch appears as a checkbox.
  case checkbox

  /// A style indicating that the switch appears as an on/off slider.
  case sliding
  }
}
