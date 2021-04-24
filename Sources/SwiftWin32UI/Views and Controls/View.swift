// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A type that represents part of your app’s user interface and provides
/// modifiers that you use to configure views.
public protocol View {
  /// The type of view representing the body of this view.
  associatedtype Body: View

  /// The content and behavior of the view.
  @ViewBuilder
  var body: Self.Body { get }
}
