// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

#if swift(>=5.7)
import CoreGraphics
#endif

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

extension Button {
  /// Specifies the style of a button.
  public enum ButtonType: Int {
    /// No button style.
    case custom

    /// A system style button, such as those shown in navigation bars and
    /// toolbars.
    case system

    /// A detail disclosure button.
    case detailDisclosure

    /// An information button that has a light background.
    case infoLight

    /// An information button that has a dark background.
    case infoDark

    /// A contact add button.
    case contactAdd

    /// A standard system button without a blurred background view.
    case plain

    /// A close button to dismiss panels and views.
    case close
  }
}

/// A control that executes your custom code in response to user interactions.
public class Button: Control {
  private static let `class`: WindowClass = WindowClass(named: WC_BUTTON)

  // MSDN:
  // A button sends the `BN_DISABLE`, `BN_PUSHED`, `BN_KILLFOCUS`, `BN_PAINT`,
  // `BN_SETFOCUS`, and `BN_UNPUSHED` notification codes only if it has the
  // `BS_NOFITY` style.
  private static let style: WindowStyle =
      (base: WS_TABSTOP | DWORD(BS_MULTILINE | BS_NOTIFY | BS_PUSHBUTTON),
       extended: 0)

  // MARK - Creating Buttons

  /// Creates a new button with the specified frame.
  public init(frame: Rect) {
    super.init(frame: frame, class: Button.class, style: Button.style)

    _ = SetWindowSubclass(hWnd, SwiftButtonProc, UINT_PTR(1),
                          unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  /// Creates a new button with the specified frame, registers the primary
  /// action event, and sets the title and image to the action's title and
  /// image.
  public convenience init(frame: Rect, primaryAction: Action?) {
    self.init(frame: frame)
    if let action = primaryAction {
      self.setTitle(action.title, forState: .normal)
      self.addAction(action, for: .primaryActionTriggered)
    }
  }

  // MARK - Configuring the Button Title

  /// Sets the title to use for the specified state.
  public func setTitle(_ title: String?, forState state: Control.State) {
    // FIXME(compnerd) handle title setting for different states
    assert(state == .normal, "state handling not yet implemented")
    SetWindowTextW(hWnd, title?.wide)
  }
}
