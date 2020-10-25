/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

extension Never: View {
}

extension Never: Scene {
}

extension Never {
  public typealias Body = Never

  public var body: Never {
    fatalError("\(#function) not yet implemented")
  }
}
