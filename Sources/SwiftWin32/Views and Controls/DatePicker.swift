/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

private let SwiftDatePickerProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let datepicker: DatePicker? =
      unsafeBitCast(dwRefData, to: AnyObject.self) as? DatePicker
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public enum DatePickerStyle: Int {
case automatic
case wheels
case compact
case inline
}

public class DatePicker: Control {
  private static let `class`: WindowClass =
      WindowClass(named: DATETIMEPICK_CLASS)
  private static let style: WindowStyle =
      (base: WS_POPUP | WS_TABSTOP, extended: 0)

  /// Configuring the Date Picker Style

  public private(set) var datePickerStyle: DatePickerStyle = .inline
  public private(set) var preferredDatePickerStyle: DatePickerStyle = .automatic {
    didSet { fatalError("not yet implemented") }
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: DatePicker.class, style: DatePicker.style)
    SetWindowSubclass(hWnd, SwiftDatePickerProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }
}
