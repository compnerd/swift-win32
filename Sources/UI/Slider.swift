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

public class Slider: Control {
  private static let `class`: WindowClass = WindowClass(named: TRACKBAR_CLASS)
  private static let style: WindowStyle =
      (base: DWORD(WS_VISIBLE | TBS_TRANSPARENTBKGND), extended: 0)

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
