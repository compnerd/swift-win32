// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
// SPDX-License-Identifier: BSD-3-Clause

import ucrt

extension Array where Element == UInt16 {
  internal init(from string: String) {
    self = string.withCString(encodedAs: UTF16.self) { buffer in
      Array<UInt16>(unsafeUninitializedCapacity: string.utf16.count + 1) {
        wcscpy_s($0.baseAddress, $0.count, buffer)
        $1 = $0.count
      }
    }
  }
}

extension Array where Element: Equatable {
  mutating func remove(object: Element) {
    if let index = firstIndex(of: object) { remove(at: index) }
  }
}
