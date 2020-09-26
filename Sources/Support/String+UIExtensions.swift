/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import ucrt

public extension String {
  var LPCWSTR: [UInt16] {
    return self.withCString(encodedAs: UTF16.self) { buffer in
      Array<UInt16>(unsafeUninitializedCapacity: self.utf16.count + 1) {
        wcscpy_s($0.baseAddress, $0.count, buffer)
        $1 = $0.count
      }
    }
  }
}

