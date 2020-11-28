/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

@frozen
public struct EmptyView: View {
  public typealias Body = Never

  @inlinable
  public init() {
  }
}
