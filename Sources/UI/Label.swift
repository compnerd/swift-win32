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

public class Label: Control {
  public static let `class`: WindowClass = WindowClass(named: "STATIC")
  public static let style: WindowStyle =
      WindowStyle(base: DWORD(WS_TABSTOP | WS_VISIBLE), extended: 0)

  public var font: Font! {
    get {
      let lResult: LRESULT = SendMessageW(hWnd, UINT(WM_GETFONT), 0, 0)
      return Font(FontHandle(referencing: HFONT(bitPattern: Int(lResult))))
    }
    set(font) {
      SendMessageW(hWnd, UINT(WM_SETFONT),
                   unsafeBitCast(font.hFont.value, to: WPARAM.self), LPARAM(1))
    }
  }

  public var text: String? {
    get {
      let szLength = SendMessageW(hWnd, UINT(WM_GETTEXTLENGTH), 0, 0)
      let wszBuffer: [WCHAR] =
          Array<WCHAR>(repeating: 0, count: Int(szLength) + 1)
      _ = wszBuffer.withUnsafeBufferPointer {
        SendMessageW(hWnd, UINT(WM_GETTEXT), WPARAM(wszBuffer.count),
                     unsafeBitCast($0, to: LPARAM.self))
      }
      return String(decoding: wszBuffer, as: UTF16.self)
    }
    set(string) {
      SetWindowTextW(hWnd, string?.LPCWSTR)
    }
  }

  public override init(frame: Rect, `class`: WindowClass = Label.class,
                       style: WindowStyle = Label.style) {
    super.init(frame: frame, class: `class`, style: style)
  }

  public convenience init(frame: Rect = .zero, `class`: WindowClass = Label.class,
                          style: WindowStyle = Label.style, title: String) {
    self.init(frame: frame, class: `class`, style: style)
    SetWindowTextW(hWnd, title.LPCWSTR)
  }
}
