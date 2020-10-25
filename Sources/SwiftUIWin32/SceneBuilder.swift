/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

@resultBuilder
public struct SceneBuilder {
  public static func buildBlock<Content: Scene>(_ content: Content) -> Content {
    fatalError("\(#function) not yet implemented")
  }
}
