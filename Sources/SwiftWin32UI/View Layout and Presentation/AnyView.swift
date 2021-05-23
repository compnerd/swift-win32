// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

@usableFromInline
internal class AnyViewStorageBase {
}

internal class AnyViewStorage<ViewType: View>: AnyViewStorageBase {
  public var view: ViewType

  init(_ view: ViewType) {
    self.view = view
  }
}

/// A type-erased view.
///
/// An `AnyView` allows changing the type of view used in a given view
/// hierarchy. Whenever the type of view used with an `AnyView` changes, the old
/// hierarchy is destroyed and a new hierarchy is created for the new type.
@frozen
public struct AnyView: View {
  public typealias Body = Never

  internal var storage: AnyViewStorageBase

  // MARK - Creating a View

  /// Create an instance that type-erases `view`.
  public init<ViewType: View>(_ view: ViewType) {
    self.storage = AnyViewStorage<ViewType>(view)
  }

  @_alwaysEmitIntoClient
  public init<ViewType: View>(erasing view: ViewType) {
    self.init(view)
  }
}
