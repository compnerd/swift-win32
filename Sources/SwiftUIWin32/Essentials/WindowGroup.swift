/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public struct WindowGroup<Content: View>: Scene {
  public var body: some Scene {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Creating a Window Group

  public init(@ViewBuilder content: () -> Content) {
  }
}
