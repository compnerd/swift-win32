/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public protocol View {
  associatedtype Body: View

  @ViewBuilder
  var body: Self.Body { get }
}
