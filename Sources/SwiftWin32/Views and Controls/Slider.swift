// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

/// A control for selecting a single value from a continuous range of values.
public class Slider: Control {
  private static let `class`: WindowClass = WindowClass(named: TRACKBAR_CLASS)
  private static let style: WindowStyle =
      (base: WS_POPUP | DWORD(TBS_HORZ | TBS_TRANSPARENTBKGND), extended: 0)

  // MARK - Accessing the Slider's Value

  /// The slider’s current value.
  public var value: Float {
    get {
      Float(SendMessageW(hWnd, UINT(TBM_GETPOS), 0, 0)) / 100.0
    }
    set(value) {
      _ = SendMessageW(hWnd, UINT(TBM_SETPOS), WPARAM(1), LPARAM(value * 100.0))
    }
  }

  // MARK - Accessing the Slider's Value Limits

  /// The minimum value of the slider.
  public var minimumValue: Float {
    get {
      Float(SendMessageW(self.hWnd, UINT(TBM_GETRANGEMIN), 0, 0)) / 100.0
    }
    set(value) {
      _ = SendMessageW(self.hWnd, UINT(TBM_SETRANGEMIN),
                       WPARAM(1), LPARAM(value * 100.0))
    }
  }

  /// The maximum value of the slider.
  public var maximumValue: Float {
    get {
      Float(SendMessageW(self.hWnd, UINT(TBM_GETRANGEMAX), 0, 0)) / 100.0
    }
    set(value) {
      _ = SendMessageW(self.hWnd, UINT(TBM_SETRANGEMAX),
                       WPARAM(1), LPARAM(value * 100.0))
    }
  }

  // MARK -

  public init(frame: Rect) {
    super.init(frame: frame, class: Slider.class, style: Slider.style)
    _ = SendMessageW(self.hWnd, UINT(TBM_SETLINESIZE), WPARAM(1), LPARAM(100))
  }
}
