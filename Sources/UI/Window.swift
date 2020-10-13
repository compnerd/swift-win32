/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

private let SwiftWindowProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
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
      (base: DWORD(WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME),
       extended: 0)

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

extension Window {
  public var isMaximizable: Bool {
    get { self.GWL_STYLE & WS_MAXIMIZEBOX == WS_MAXIMIZEBOX }
    set {
      self.GWL_STYLE = newValue ? self.GWL_STYLE | WS_MAXIMIZEBOX
                                : self.GWL_STYLE & ~WS_MAXIMIZEBOX
    }
  }

  public var isMinimizable: Bool {
    get { self.GWL_STYLE & WS_MINIMIZEBOX == WS_MINIMIZEBOX }
    set {
      self.GWL_STYLE = newValue ? self.GWL_STYLE | WS_MINIMIZEBOX
                                : self.GWL_STYLE & ~WS_MINIMIZEBOX
    }
  }
}
