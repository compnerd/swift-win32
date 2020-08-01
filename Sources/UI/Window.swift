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

public protocol WindowDelegate: class {
  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
}

public extension WindowDelegate {
  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }
}

internal let SwiftWindowProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let window: Window? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Window
  switch uMsg {
  case UINT(WM_DESTROY):
    // TODO(compnerd) we should handle multiple scenes, which can have multiple
    // Windows, so the destruction of a window should not post the quit message
    // to the message loop.
    Application.shared.windows.removeAll(where: { $0.hWnd == window!.hWnd })
    if window?.isKeyWindow ?? false {
      window?.resignKey()
      PostQuitMessage(0)
    }
  case UINT(WM_COMMAND):
    if window?.delegate?.OnCommand(hWnd, wParam, lParam) == 0 {
      return 0
    }
  case UINT(WM_DPICHANGED):
    if let hMonitor = MonitorFromWindow(hWnd, DWORD(MONITOR_DEFAULTTONULL)) {
      let screen = Screen.screens.filter { $0 == hMonitor }.first
      screen?.traitCollectionDidChange(screen?.traitCollection)
    }
  default:
    break
  }
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Window: View {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Window",
                  style: UInt32(CS_HREDRAW | CS_VREDRAW),
                  hbrBackground: GetSysColorBrush(COLOR_3DFACE),
                  hCursor: LoadCursorW(nil, IDC_ARROW))
  private static let style: WindowStyle =
      (base: DWORD(WS_OVERLAPPEDWINDOW | UInt32(WS_VISIBLE)), extended: 0)

  // TODO(compnerd) remove this in favour of the view controller
  public weak var delegate: WindowDelegate?

  /// Configuring the Window
  public var rootViewController: ViewController? {
    didSet { self.rootViewController?.view = self }
  }

  // TODO(compnerd) handle set
  public private(set) var windowLevel: Window.Level = .normal

  // TODO(compnerd) handle set
  public private(set) var canResizeToFitContent: Bool = true

  // TODO(compnerd) remove this in favour of scene management interface;
  // windowScene provides the scene associated with the window, and the scene is
  // attached to a window.
  public var screen: Screen {
    let hMonitor: HMONITOR =
        MonitorFromWindow(hWnd, DWORD(MONITOR_DEFAULTTOPRIMARY))
    return Screen.screens.filter { $0 == hMonitor }.first!
  }

  /// Making Windows Key
  var isKeyWindow: Bool {
    guard let keyWindow = Application.shared.keyWindow else { return false }
    return self.hWnd == keyWindow.hWnd
  }

  public func makeKeyAndVisible() {
    self.makeKey()
    self.isHidden = false
  }

  public func makeKey() {
    Application.shared.keyWindow?.resignKey()
    Application.shared.keyWindow = self
    Application.shared.keyWindow?.becomeKey()
  }

  public func becomeKey() {
    // TODO(compnerd) post didBecomKeyNotification
  }

  public func resignKey() {
    // TODO(compnerd) post didResignKeyNotification
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: Window.class, style: Window.style)
    SetWindowSubclass(hWnd, SwiftWindowProc, UINT_PTR(0),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    // TODO(compnerd) insert/sort by z-order
    Application.shared.windows.append(self)
  }
}

extension Window {
  public struct Level: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Double

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Window.Level {
  public static let normal: Window.Level = Window.Level(rawValue: 0.0)
  public static let statusBar: Window.Level = Window.Level(rawValue: 1000.0)
  public static let alert: Window.Level = Window.Level(rawValue: 2000.0)
}
