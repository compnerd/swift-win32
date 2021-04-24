// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

@resultBuilder
public struct ViewBuilder {
  public static func buildBlock() -> EmptyView {
    return EmptyView()
  }

  public static func buildBlock<Content: View>(_ content: Content) -> Content {
    return content
  }
}
