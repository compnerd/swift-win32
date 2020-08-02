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

@propertyWrapper
public struct _Win32WindowText {
  public var wrappedValue: String? {
    get { fatalError() }
    set { fatalError() }
  }

  public static subscript<EnclosingSelf: View>(_enclosingInstance view: EnclosingSelf,
                                               wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, String?>,
                                               storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, _Win32WindowText>)
      -> String? {
    get {
      let szLength: Int32 = GetWindowTextLengthW(view.hWnd)

#if swift(<5.3)
      let buffer: UnsafeMutablePointer<WCHAR> =
        UnsafeMutablePointer<WCHAR>.allocate(capacity: Int(szLength) + 1)
      defer { buffer.deallocate() }

      GetWindowTextW(view.hWnd, buffer, szLength + 1)
      return String(decodingCString: buffer, as: UTF16.self)
#else
      let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(szLength) + 1) {
        $1 = Int(GetWindowTextW(view.hWnd, $0.baseAddress!, CInt($0.count)))
      }
      return String(decodingCString: buffer, as: UTF16.self)
#endif
    }
    set(value) {
      SetWindowTextW(view.hWnd, value?.LPCWSTR)
    }
  }

  public init() {
  }
}

@propertyWrapper
public struct _Win32Font {
  private var storage: Font?

  public var wrappedValue: Font? {
    get { fatalError() }
    set { fatalError() }
  }

  public static subscript<EnclosingSelf: View>(_enclosingInstance view: EnclosingSelf,
                                               wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Font?>,
                                               storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, _Win32Font>)
      -> Font? {
    get {
      guard view[keyPath: storageKeyPath].storage == nil else {
        return view[keyPath: storageKeyPath].storage
      }
      let lResult: LRESULT = SendMessageW(view.hWnd, UINT(WM_GETFONT), 0, 0)
      return Font(FontHandle(referencing: HFONT(bitPattern: Int(lResult))))
    }
    set(font) {
      view[keyPath: storageKeyPath].storage = font
      SendMessageW(view.hWnd, UINT(WM_SETFONT),
                   unsafeBitCast(font?.hFont.value, to: WPARAM.self), LPARAM(1))
    }
  }

  public init() {
  }
}
