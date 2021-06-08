// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

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
      guard szLength > 0 else { return nil }

      let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(szLength) + 1) {
        $1 = Int(GetWindowTextW(view.hWnd, $0.baseAddress!, CInt($0.count)))
      }
      return String(decodingCString: buffer, as: UTF16.self)
    }
    set(value) {
      SetWindowTextW(view.hWnd, value?.wide)
    }
  }

  public init() {
  }
}
