// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

extension String {
  public var wide: [UInt16] {
    return Array<UInt16>(from: self)
  }
}

