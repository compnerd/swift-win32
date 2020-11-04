/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

public class Slider: Control {
  private static let `class`: WindowClass = WindowClass(named: TRACKBAR_CLASS)
  private static let style: WindowStyle =
      (base: WS_POPUP | DWORD(TBS_HORZ | TBS_TRANSPARENTBKGND), extended: 0)

  public var value: Float {
    get { Float(SendMessageW(hWnd, UINT(TBM_GETPOS), 0, 0)) / 100.0 }
    set(value) {
      SendMessageW(hWnd, UINT(TBM_SETPOS), WPARAM(1), LPARAM(value * 100.0))
    }
  }

  public var minimumValue: Float {
    get { Float(SendMessageW(hWnd, UINT(TBM_GETRANGEMIN), 0, 0)) / 100.0 }
    set(value) {
      SendMessageW(hWnd, UINT(TBM_SETRANGEMIN), WPARAM(1), LPARAM(value * 100.0))
    }
  }

  public var maximumValue: Float {
    get { Float(SendMessageW(hWnd, UINT(TBM_GETRANGEMAX), 0, 0)) / 100.0 }
    set(value) {
      SendMessageW(hWnd, UINT(TBM_SETRANGEMAX), WPARAM(1), LPARAM(value * 100.0))
    }
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: Slider.class, style: Slider.style)
    SendMessageW(hWnd, UINT(TBM_SETLINESIZE), WPARAM(1), LPARAM(100))
  }
}
