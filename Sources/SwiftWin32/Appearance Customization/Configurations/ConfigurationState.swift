// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The requirements for an object that encapsulate a view's state.
public protocol ConfigurationState {
  // MARK - Managing Configuration States

  /// The traits that describe the current layout environment of the view, such
  /// as the user interface style and layout direction.
  var traitCollection: TraitCollection { get set }

  /// Accesses custom states by key.
  subscript(key: ConfigurationStateCustomKey) -> AnyHashable? { get set }

  // MARK - Creating a Configuration State Manually

  /// Creates a View configuration state with the specified trait collection.
  init(traitCollection: TraitCollection)
}
