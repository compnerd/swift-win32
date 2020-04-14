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

public typealias WindowStyle = (base: DWORD, extended: DWORD)

public class View {
  internal var hWnd: HWND
  internal var `class`: WindowClass
  internal var style: WindowStyle

  // TODO(compnerd) handle set
  public var subviews: [View] = []
  public var superview: View?
  public var frame: Rect

  public init(frame: Rect, `class`: WindowClass, style: WindowStyle) {
    self.class = `class`
    _ = self.class.register()
    self.style = style

    self.frame = frame
    if !self.frame.isAnyPointDefault {
      var r = RECT(from: self.frame);
      // TODO(compnerd) use AdjustWindowRectExForDpi
      AdjustWindowRectEx(&r, self.style.base, false, self.style.extended)
      self.frame = Rect(from: r)
    }
    self.hWnd =
        CreateWindowExW(self.style.extended, self.class.name, "".LPCWSTR,
                        self.style.base,
                        Int32(self.frame.origin.x),
                        Int32(self.frame.origin.y),
                        Int32(self.frame.size.width),
                        Int32(self.frame.size.height),
                        nil, nil, GetModuleHandleW(nil), nil)
  }

  deinit {
    _ = self.class.unregister()
  }

  public func addSubview(_ view: View) {
    if SetWindowLongPtrW(view.hWnd, GWL_STYLE,
                         LONG_PTR(view.style.base | DWORD(WS_CHILD))) == 0 {
      SetWindowLongPtrW(view.hWnd, GWL_STYLE, LONG_PTR(view.style.base))
      return
    }
    view.style.base |= DWORD(WS_CHILD)

    SetParent(view.hWnd, self.hWnd)

    // We *must* call `SetWindowPos` after the `SetWindowLong` to have the
    // changes take effect.  Adjust the client rectangle and resize the view
    // when reparenting.  This ensures that the requested size is honoured
    // properly.
    if !view.frame.isAnyPointDefault {
      var r = RECT(from: view.frame);
      // TODO(compnerd) use AdjustWindowRectExForDpi
      AdjustWindowRectEx(&r, view.style.base, false, view.style.extended)
      view.frame = Rect(from: r)

      SetWindowPos(view.hWnd, nil,
                   Int32(view.frame.origin.x), Int32(view.frame.origin.y),
                   Int32(view.frame.size.width), Int32(view.frame.size.height),
                   UINT(SWP_NOZORDER | SWP_FRAMECHANGED))
    } else {
      // FIXME(compnerd) how we resize the client rectangle here?
      SetWindowPos(view.hWnd, nil,
                   Int32(view.frame.origin.x), Int32(view.frame.origin.y),
                   Int32(view.frame.size.width), Int32(view.frame.size.height),
                   UINT(SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED))
    }

    view.superview = self
    subviews.append(view)
  }
}
