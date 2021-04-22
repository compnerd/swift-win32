/**
 * Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A view type that compares itself against its previous value and prevents its
/// child updating if its new value is the same as its old value.
@frozen
public struct EquatableView<Content: View & Equatable>: View {
  public typealias Body = Never

  // MARK - Creating an Equatable View

  public var content: Content

  @inlinable
  public init(content: Content) {
    self.content = content
  }
}
