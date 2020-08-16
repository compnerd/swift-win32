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
      (base: WS_POPUP | DWORD(WS_TABSTOP), extended: 0)

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
