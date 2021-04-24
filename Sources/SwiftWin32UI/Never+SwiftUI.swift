// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

extension Never: View {
}

extension Never: Scene {
}

extension Never {
  public typealias Body = Never
}

extension View where Body == Never {
  public var body: Never {
    fatalError("\(#function): View \(type(of: self)) does not have a body")
  }
}
