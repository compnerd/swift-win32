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

internal let SwiftStepperProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let stepper: Stepper? =
      unsafeBitCast(dwRefData, to: AnyObject.self) as? Stepper
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Stepper: Control {
  private static let `class`: WindowClass = WindowClass(named: UPDOWN_CLASS)
  private static let style: WindowStyle =
      (base: UInt32(UDS_HORZ) | WS_POPUP | DWORD(WS_TABSTOP), extended: 0)

  /// Configuring the Stepper
  public var isContinuous: Bool = true
  public var autorepeat: Bool = true
  public var wraps: Bool = false
  public var minimumValue: Double = 0.0
  public var maximumValue: Double = 100.0
  public var stepValue: Double = 1.0

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
    super.init(frame: frame, class: Stepper.class, style: Stepper.style)
    SetWindowSubclass(hWnd, SwiftStepperProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    // NOTE: we must manually initialize the value
    self.value = 0.0
  }
}
