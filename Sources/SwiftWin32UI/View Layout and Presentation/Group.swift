// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// An affordance for grouping view content.
@frozen
public struct Group<Content> {
  public typealias Body = Never

  @usableFromInline
  internal var content: Content
}

// MARK - Creating a Group

extension Group where Content: View {
  /// Available when `Content` conforms to `View`.
  @inlinable
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}

extension Group where Content: Scene {
  /// Available when `Content` conforms to `Scene`.
  @inlinable
  public init(@SceneBuilder content: () -> Content) {
    self.content = content()
  }
}

extension Group: CustomStringConvertible {
  public var description: String {
    "<Group: \(content)>"
  }
}
