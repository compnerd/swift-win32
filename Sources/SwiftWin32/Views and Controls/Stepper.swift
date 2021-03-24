/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

// Notification Proxy

// When the Window is created, the initial parent is cached.  This cache cannot
// be updated.  Instead, we always parent any stepper control to the
// `Swift.Stepper.Proxy` which is process-wide.  All notifications
// about the control events will be dispatched by the proxy.
//
// In order to facilitate this, the control will stash the `self` (instance)
// pointer in `GWLP_USERDATA`.  When we receive a `WM_HSCROLL` event, the
// `lParam` contains the handle to the control.  We use this to query the
// stashed instance pointer and dispatch the action to the control, allowing the
// action targets to be invoked.

private let SwiftStepperWindowProc: WNDPROC = { (hWnd, uMsg, wParam, lParam) in
  switch uMsg {
  case UINT(WM_HSCROLL):
    guard let hSender = HWND(bitPattern: UInt(lParam)) else { break }

    let lpInstance = GetWindowLongPtrW(hSender, GWLP_USERDATA)
    if lpInstance == 0 { break }

    if let stepper = unsafeBitCast(lpInstance, to: AnyObject.self) as? Stepper {
      stepper.sendActions(for: .valueChanged)
    }
  default:
    break
  }

  return DefWindowProcW(hWnd, uMsg, wParam, lParam)
}

private class StepperProxy {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Stepper.Proxy",
                  WindowProc: SwiftStepperWindowProc)

  fileprivate var hWnd: HWND!

  fileprivate init() {
    _ = StepperProxy.class.register()
    self.hWnd = CreateWindowExW(0, StepperProxy.class.name, nil, 0, 0, 0, 0, 0,
                                HWND_MESSAGE, nil, GetModuleHandleW(nil), nil)!
  }

  deinit {
    _ = DestroyWindow(self.hWnd)
    _ = StepperProxy.class.unregister()
  }
}


private let SwiftStepperProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let stepper: Stepper? =
      unsafeBitCast(dwRefData, to: AnyObject.self) as? Stepper
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

/// A control for incrementing or decrementing a value.
public class Stepper: Control {
  private static let `class`: WindowClass = WindowClass(named: UPDOWN_CLASS)
  private static let style: WindowStyle =
      (base: UInt32(UDS_HORZ) | WS_POPUP | WS_TABSTOP, extended: 0)

  private static var proxy: StepperProxy = StepperProxy()

  // MARK - Configuring the Stepper

  public var isContinuous: Bool { fatalError("not yet implemented") }
  public var autorepeat: Bool { fatalError("not yet implemented") }

  /// A Boolean value that determines whether the stepper can wrap its value to
  /// the minimum or maximum value when incrementing and decrementing the value.
  public var wraps: Bool {
    get { self.GWL_STYLE & UDS_WRAP == UDS_WRAP }
    set {
      self.GWL_STYLE = newValue ? self.GWL_STYLE | UDS_WRAP
                                : self.GWL_STYLE & ~UDS_WRAP
    }
  }

  /// The lowest possible numeric value for the stepper.
  public var minimumValue: Double {
    get {
      var value: CInt = 0
      _ = withUnsafeMutablePointer(to: &value) {
        SendMessageW(self.hWnd, UINT(UDM_GETRANGE32),
                     WPARAM(UInt(bitPattern: $0)), 0)
      }
      return Double(value)
    }
    set {
      let newMaximum =
          self.maximumValue >= newValue ? self.minimumValue : newValue

      _ = SendMessageW(self.hWnd, UINT(UDM_SETRANGE32),
                       WPARAM(CInt(newValue)), LPARAM(CInt(newMaximum)))
    }
  }

  /// The highest possible numeric value for the stepper.
  public var maximumValue: Double {
    get {
      var value: CInt = 0
      _ = withUnsafeMutablePointer(to: &value) {
        SendMessageW(self.hWnd, UINT(UDM_GETRANGE32),
                     0, LPARAM(UInt(bitPattern: $0)))
      }
      return Double(value)
    }
    set {
      let newMinimum =
          self.minimumValue <= newValue ? self.minimumValue : newValue

      _ = SendMessageW(self.hWnd, UINT(UDM_SETRANGE32),
                       WPARAM(CInt(newMinimum)), LPARAM(CInt(newValue)))
    }
  }

  /// The step, or increment, value for the stepper.
  public var stepValue: Double {
    get {
      var value: UDACCEL = UDACCEL(nSec: 0, nInc: 0)
      _ = withUnsafeMutablePointer(to: &value) {
        SendMessageW(self.hWnd, UINT(UDM_GETACCEL),
                     WPARAM(MemoryLayout<UDACCEL>.size),
                     LPARAM(UInt(bitPattern: $0)))
      }
      return Double(value.nInc)
    }
    set {
      var value: UDACCEL = UDACCEL(nSec: 0, nInc: 0)
      _ = withUnsafeMutablePointer(to: &value) {
        SendMessageW(self.hWnd, UINT(UDM_GETACCEL),
                     WPARAM(1), LPARAM(UInt(bitPattern: $0)))
      }
      value.nInc = DWORD(newValue)
      _ = withUnsafeMutablePointer(to: &value) {
        SendMessageW(self.hWnd, UINT(UDM_SETACCEL),
                     WPARAM(1), LPARAM(UInt(bitPattern: $0)))
      }
    }
  }

  // MARK - Accessing the Stepper's Value

  /// The numeric value of the stepper.
  public var value: Double {
    get {
      let lResult: LRESULT = SendMessageW(self.hWnd, UINT(UDM_GETPOS32), 0, 0)
      return Double(lResult)
    }
    set {
      _ = SendMessageW(self.hWnd, UINT(UDM_SETPOS32), WPARAM(DWORD(newValue)), 0)
    }
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: Stepper.class, style: Stepper.style,
               parent: Stepper.proxy.hWnd)

    _ = SetWindowLongPtrW(self.hWnd, GWLP_USERDATA,
                          unsafeBitCast(self as AnyObject, to: LONG_PTR.self))
    _ = SetWindowSubclass(self.hWnd, SwiftStepperProc, UINT_PTR(1),
                          unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    defer {
      self.wraps = false
      self.minimumValue = 0.0
      self.maximumValue = 100.0
      self.stepValue = 1.0
      self.value = 0.0
    }
  }
}
