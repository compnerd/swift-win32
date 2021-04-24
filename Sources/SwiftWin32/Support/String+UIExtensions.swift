// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

extension String {
  internal init(from utf16: [UInt16]) {
    self = utf16.withUnsafeBufferPointer {
      String(decodingCString: $0.baseAddress!, as: UTF16.self)
    }
  }
}

extension String {
  public var wide: [UInt16] {
    return Array<UInt16>(from: self)
  }
}

