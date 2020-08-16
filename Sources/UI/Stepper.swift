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

// Notification Proxy

// When the Window is created, the initial parent is cached.  This cache cannot
// be updated.  Instead, we always parent any stepper control to the
// `Swift.Stepper.MessengerProxy` which is process-wide.  All notifications
// about the control events will be dispatched by the proxy.
//
// In order to facilitate this, the control will stash the `self` (instance)
// pointer in `GWLP_USERDATA`.  When we receive a `WM_HSCROLL` event, the
// `lParam` contains the handle to the control.  We use this to query the
// stashed instance pointer and dispatch the action to the control, allowing the
// action targets to be invoked.

private let SwiftStepperMessengerProc: WNDPROC = { (hWnd, uMsg, wParam, lParam) in
  switch uMsg {
  case UINT(WM_HSCROLL):
    guard let hSender = HWND(bitPattern: UInt(lParam)) else { break }

    let lpInstance = GetWindowLongPtrW(hSender, GWLP_USERDATA)
    if lpInstance == 0 { break }

    let stepper: Stepper! =
        unsafeBitCast(lpInstance, to: AnyObject.self) as? Stepper
    stepper.sendActions(for: .valueChanged)
  default:
    break
  }

  return DefWindowProcW(hWnd, uMsg, wParam, lParam)
}

private class StepperMessengerProxy {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil),
                  name: "Swift.Stepper.MessengerProxy",
                  WindowProc: SwiftStepperMessengerProc)

  fileprivate var hWnd: HWND!

  fileprivate init() {
    _ = StepperMessengerProxy.class.register()
    self.hWnd = CreateWindowExW(0, StepperMessengerProxy.class.name, nil, 0,
                                0, 0, 0, 0,
                                HWND_MESSAGE, nil, GetModuleHandleW(nil), nil)!
  }

  deinit {
    _ = DestroyWindow(self.hWnd)
    _ = StepperMessengerProxy.class.unregister()
  }
}


private let SwiftStepperProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let stepper: Stepper? =
      unsafeBitCast(dwRefData, to: AnyObject.self) as? Stepper
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Stepper: Control {
  private static let `class`: WindowClass = WindowClass(named: UPDOWN_CLASS)
  private static let style: WindowStyle =
      (base: UInt32(UDS_HORZ) | WS_POPUP | DWORD(WS_TABSTOP), extended: 0)

  private static var proxy: StepperMessengerProxy = StepperMessengerProxy()

  /// Configuring the Stepper
  public var isContinuous: Bool { fatalError("not yet implemented") }
  public var autorepeat: Bool { fatalError("not yet implemented") }
  public var wraps: Bool {
    get { return GetWindowLongW(self.hWnd, GWL_STYLE) & UDS_WRAP == UDS_WRAP }
    set {
      var lStyle: LONG = GetWindowLongW(self.hWnd, GWL_STYLE)
      lStyle = newValue ? lStyle | UDS_WRAP : lStyle & ~UDS_WRAP
      _ = SetWindowLongW(self.hWnd, GWL_STYLE, lStyle)
    }
  }
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
      _ = SendMessageW(self.hWnd, UINT(UDM_SETRANGE32),
                       WPARAM(CInt(newValue)), LPARAM(CInt(self.maximumValue)))
    }
  }
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
      _ = SendMessageW(self.hWnd, UINT(UDM_SETRANGE32),
                       WPARAM(CInt(self.minimumValue)), LPARAM(CInt(newValue)))
    }
  }
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

  /// Accessing the Stepper's Value
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
