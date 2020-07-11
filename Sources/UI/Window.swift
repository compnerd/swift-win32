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
  func OnCreate(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnPaint(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnDestroy(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
}

public extension WindowDelegate {
  func OnCreate(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnPaint(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnDestroy(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }
}

internal let SwiftWindowProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let window: Window? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Window
  switch uMsg {
  case UINT(WM_CREATE):
    if window?.delegate?.OnCreate(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_PAINT):
    if window?.delegate?.OnPaint(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_DESTROY):
    if window?.delegate?.OnDestroy(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_COMMAND):
    if window?.delegate?.OnCommand(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  default:
    break
  }
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Window: View {
  internal static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Window",
                  style: UInt32(CS_HREDRAW | CS_VREDRAW),
                  hbrBackground: GetSysColorBrush(COLOR_3DFACE),
                  hCursor: LoadCursorW(nil, IDC_ARROW))
  internal static let style: WindowStyle =
      (base: DWORD(WS_OVERLAPPEDWINDOW | UInt32(WS_VISIBLE)), extended: 0)

  public weak var delegate: WindowDelegate?

  public init(frame: Rect) {
    super.init(frame: frame, class: Window.class, style: Window.style)
    SetWindowSubclass(hWnd, SwiftWindowProc, UINT_PTR(0),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }
}

extension Window {
  public convenience init(frame: Rect = .zero, title: String) {
    self.init(frame: frame)
    SetWindowTextW(hWnd, title.LPCWSTR)
  }
}
