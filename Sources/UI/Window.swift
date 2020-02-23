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
  func OnQuit(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
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

  func OnQuit(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
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
  case UINT(WM_QUIT):
    if window?.delegate?.OnQuit(hWnd, wParam, lParam) == 0 {
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
  public static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Window")
  public static let style: WindowStyle =
      WindowStyle(base: DWORD(CS_HREDRAW | CS_VREDRAW | Int32(WS_OVERLAPPEDWINDOW) | WS_VISIBLE),
                  extended: 0)

  public weak var delegate: WindowDelegate?

  public override init(frame: Rect, `class`: WindowClass = Window.class,
                       style: WindowStyle = Window.style) {
    super.init(frame: frame, class: `class`, style: style)
    SetWindowSubclass(hWnd, SwiftWindowProc, UINT_PTR(0),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  public convenience init(frame: Rect = .zero, `class`: WindowClass = Window.class,
                          style: WindowStyle = Window.style, title: String) {
    self.init(frame: frame, class: `class`, style: style)
    SetWindowTextW(hWnd, title.LPCWSTR)
  }
}
