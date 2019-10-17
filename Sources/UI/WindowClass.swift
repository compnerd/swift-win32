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

public typealias WindowProc =
    @convention(c) (HWND?, UINT, WPARAM, LPARAM) -> LRESULT

public class WindowClass {
  internal var name: [WCHAR]
  internal var hInstance: HINSTANCE?
  internal var value: WNDCLASSEXW?
  internal var atom: ATOM?

  public init(hInst hInstance: HINSTANCE, name: String,
              WindowProc lpfnWindowProc: WindowProc? = DefWindowProcW,
              style : UInt32 = 0, hbrBackground : UInt32 = 0 ) {
    self.name = name.LPCWSTR

    self.hInstance = hInstance
    self.value = WNDCLASSEXW(cbSize: UINT(MemoryLayout<WNDCLASSEXW>.size),
                             style: style,
                             lpfnWndProc: lpfnWindowProc,
                             cbClsExtra: 0,
                             cbWndExtra: 0,
                             hInstance: hInstance,
                             hIcon: nil,
                             hCursor: nil,
                             hbrBackground: UnsafeMutablePointer<HBRUSH__>(bitPattern: UInt(hbrBackground)),
                             lpszMenuName: nil,
                             lpszClassName: self.name,
                             hIconSm: nil)
  }

  public init(named: String) {
    self.name = named.LPCWSTR
  }

  public func register() -> Bool {
    guard value != nil, atom == nil else { return true }
    self.atom = RegisterClassExW(&value!)
    return self.atom != nil
  }

  public func unregister() -> Bool {
    guard value != nil, atom != nil else { return false }
    if UnregisterClassW(self.name, self.hInstance) {
      self.atom = nil
    }
    return self.atom == nil
  }
}
