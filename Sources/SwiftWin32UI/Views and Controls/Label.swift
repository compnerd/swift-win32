// Copyright © 2022 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import SwiftWin32

public struct Label<Title: View, Icon: View> {
}

extension Label: View {
  public typealias Body = SwiftWin32.Label

  public var body: SwiftWin32.Label {
    return SwiftWin32.Label(frame: .zero)
  }
}

extension SwiftWin32.Label: View {
  public typealias Body = Never
}
