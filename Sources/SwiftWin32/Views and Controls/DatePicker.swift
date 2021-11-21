// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

import struct Foundation.Date

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

  // MARK - Managing the Date and Calendar

  /// The date displayed by the date picker.
  public var date: Date {
    get {
      var stDateTime: SYSTEMTIME = SYSTEMTIME()
      // FIXME(compnerd) ensure that GDT_VALID is returned
      _ = withUnsafeMutablePointer(to: &stDateTime) {
        SendMessageW(self.hWnd, UINT(DTM_GETSYSTEMTIME),
                     WPARAM(0), LPARAM(UInt(bitPattern: $0)))
      }

      let ftDateTime: FILETIME = FILETIME(stDateTime)
      return Date(timeIntervalSince1970: ftDateTime.timeIntervalSince1970)
    }
    set { self.setDate(newValue, animated: false) }
  }

  /// Sets the date to display in the date picker, with an option to animate the
  /// setting.
  public func setDate(_ date: Date, animated: Bool) {
    assert(!animated, "not yet implemented")

    let ftSystemTime: FILETIME =
        FILETIME(timeIntervalSince1970: date.timeIntervalSince1970)
    let stSystemTime: SYSTEMTIME = SYSTEMTIME(ftSystemTime)

    _ = withUnsafePointer(to: stSystemTime) {
      SendMessageW(self.hWnd, UINT(DTM_SETSYSTEMTIME),
                   WPARAM(GDT_VALID), LPARAM(UInt(bitPattern: $0)))
    }
  }

  // MARK - Configuring the Date Picker Style

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
