/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import class Foundation.NSNotification
import class Foundation.NotificationCenter

private let SwiftWindowProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let window: Window? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Window

  switch uMsg {
  case UINT(WM_ACTIVATE):
    guard let window = window, let windowScene = window.windowScene else { break }
    switch LOWORD(wParam) {
    case WORD(WA_ACTIVE), WORD(WA_CLICKACTIVE):
      windowScene.delegate?.sceneDidBecomeActive(windowScene)
    case WORD(WA_INACTIVE):
      windowScene.delegate?.sceneDidEnterBackground(windowScene)
    default:
      fatalError("WM_ACTIVATE wParam: 0x\(String(wParam, radix: 16)), lParam: 0x\(String(lParam, radix: 16))")
    }
  case UINT(WM_ACTIVATEAPP):
    guard let window = window else { break }

    if wParam == 0 {
      if let windowScene = window.windowScene {
        windowScene.delegate?.sceneWillResignActive(windowScene)
      } else if window.isKeyWindow {
        Application.shared.delegate?.applicationWillResignActive(Application.shared)

        // Post ApplicationDelegate.willResignActiveNotification
        NotificationCenter.default
            .post(name: Delegate.willResignActiveNotification, object: nil)
      }
    } else {
      if let windowScene = window.windowScene {
        windowScene.delegate?.sceneDidBecomeActive(windowScene)
      } else if window.isKeyWindow {
        Application.shared.delegate?.applicationDidBecomeActive(Application.shared)

        // Post ApplicationDelegate.didBecomeActiveNotification
        NotificationCenter.default
            .post(name: Delegate.didBecomeActiveNotification, object: nil)
      }
    }
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
  case UINT(WM_GETMINMAXINFO):
    // We must have a window and size restrictions, otherwise we fallback to the
    // default behaviour.
    guard let window = window,
          let restrictions = window.windowScene?.sizeRestrictions else {
      break
    }

    // If the minimum and maximum sizes are the same, the window cannot be
    // resized, and we can simply fallback to the default bhaviour.
    if restrictions.minimumSize == restrictions.maximumSize {
      break
    }

    func ClientSizeToWindowSize(_ size: Size) -> Size {
      var rc: RECT = RECT(from: Rect(origin: .zero, size: size))
      if !AdjustWindowRectExForDpi(&rc, DWORD(window.GWL_STYLE), false,
                                   DWORD(window.GWL_EXSTYLE),
                                   GetDpiForWindow(window.hWnd)) {
        log.warning("AdjustWindowRetExForDpi: \(Error(win32: GetLastError()))")
      }
      return Rect(from: rc).size
    }

    let lpInfo: UnsafeMutablePointer<MINMAXINFO> =
        UnsafeMutablePointer<MINMAXINFO>(bitPattern: UInt(lParam))!

    // Adjust the minimum and maximum tracking size for the window.
    lpInfo.pointee.ptMinTrackSize =
        POINT(from: ClientSizeToWindowSize(restrictions.minimumSize))
    lpInfo.pointee.ptMaxTrackSize =
        POINT(from: ClientSizeToWindowSize(restrictions.maximumSize))
    lpInfo.pointee.ptMaxSize =
        POINT(from: ClientSizeToWindowSize(restrictions.maximumSize))

    return LRESULT(0)
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
      (base: DWORD(WS_OVERLAPPEDWINDOW), extended: 0)

  public init(frame: Rect) {
    super.init(frame: frame, class: Window.class, style: Window.style)
    _ = SetWindowSubclass(hWnd, SwiftWindowProc, UINT_PTR(0),
                          unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    // TODO(compnerd) insert/sort by z-order
    Application.shared.windows.append(self)
  }

  /// Creating a Window

  /// Creates a Window and associates it with the specified scene object.
  public init(windowScene: WindowScene) {
    self.windowScene = windowScene

    let frame: Rect =
        Rect(origin: Point(x: Double(CW_USEDEFAULT), y: Double(CW_USEDEFAULT)),
             size: windowScene.sizeRestrictions?.minimumSize ?? .zero)
    super.init(frame: frame, class: Window.class, style: Window.style)
    _ = SetWindowSubclass(hWnd, SwiftWindowProc, UINT_PTR(0),
                          unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
    if let restrictions = windowScene.sizeRestrictions,
        restrictions.minimumSize == restrictions.maximumSize {
      self.GWL_STYLE &= ~(WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_SIZEBOX)
    }

    windowScene.windows.append(self)
  }

  /// Configuring the Window

  /// The root view controller for the window.
  public var rootViewController: ViewController? {
    didSet { self.rootViewController?.view = self }
  }

  // TODO(compnerd) handle set
  /// The position of the window in the z-axis.
  public private(set) var windowLevel: Window.Level = .normal

  // TODO(compnerd) remove this in favour of scene management interface;
  // windowScene provides the scene associated with the window, and the scene is
  // attached to a window.
  public var screen: Screen {
    let hMonitor: HMONITOR =
        MonitorFromWindow(hWnd, DWORD(MONITOR_DEFAULTTOPRIMARY))
    return Screen.screens.filter { $0 == hMonitor }.first!
  }

  /// Making Windows Key

  /// A boolean value that indicates whether the window is the key window for the
  /// application.
  var isKeyWindow: Bool {
    guard let keyWindow = Application.shared.keyWindow else { return false }
    return self.hWnd == keyWindow.hWnd
  }

  /// Shows the window and makes it the key window.
  public func makeKeyAndVisible() {
    self.makeKey()
    self.isHidden = false
  }

  /// Makes the receiver the key window.
  public func makeKey() {
    Application.shared.keyWindow?.resignKey()
    Application.shared.keyWindow = self
    Application.shared.keyWindow?.becomeKey()
  }

  /// Called automatically to inform the window that it has become the key
  /// window.
  public func becomeKey() {
    NotificationCenter.default.post(name: Window.didBecomeKeyNotification,
                                    object: self)
  }

  /// Called automatically to inform the window that it is no longer the key
  /// window.
  public func resignKey() {
    NotificationCenter.default.post(name: Window.didResignKeyNotification,
                                    object: self)
  }

  /// Getting Related Objects

  /// The scene containing the window.
  public weak var windowScene: WindowScene? {
    didSet { fatalError("\(#function) not yet implemented") }
  }
}

/// Responding to Window-Related Notifications
extension Window {
  /// Posted whn a `Window` object becomes visible.
  public class var didBecomeVisibleNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIWindowDIdBecomeVisibleNotification")
  }

  /// Posted when a `Window` object becomes hidden.
  public class var didBecomeHiddenNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIWindowDidBecomeHiddenNotification")
  }

  /// Posted whenever a `Window` object becomes the key window.
  public class var didBecomeKeyNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIWindowDidBecomeKeyNotification")
  }

  /// Posted when a `Window` object resigns its status as main window.
  public class var didResignKeyNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIWindowDidResignKeyNotification")
  }
}

extension Window {
  /// The positioning of windows relative to each other.
  public struct Level: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Double

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Window.Level {
  /// The default level.
  public static var normal: Window.Level {
    Window.Level(rawValue: 0.0)
  }

  /// The level for a status window.
  public static var statusBar: Window.Level {
    Window.Level(rawValue: 1000.0)
  }

  /// The level for an alert view.
  public static var alert: Window.Level {
    Window.Level(rawValue: 2000.0)
  }
}

extension Window {
  public var isMinimizable: Bool {
    get { self.GWL_STYLE & WS_MINIMIZEBOX == WS_MINIMIZEBOX }
    set {
      self.GWL_STYLE = newValue ? self.GWL_STYLE | WS_MINIMIZEBOX
                                : self.GWL_STYLE & ~WS_MINIMIZEBOX
    }
  }
}
