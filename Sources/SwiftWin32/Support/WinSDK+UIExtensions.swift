// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3

import WinSDK

internal func UserData<Type: AnyObject>(from hWnd: HWND?) -> Type? {
  guard let hWnd = hWnd else { return nil }

  let lpUserData = GetWindowLongPtrW(hWnd, GWLP_USERDATA)
  return lpUserData == 0 ? nil
                         : unsafeBitCast(lpUserData, to: AnyObject.self) as? Type
}
