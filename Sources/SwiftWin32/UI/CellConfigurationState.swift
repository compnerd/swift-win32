/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A structure that encapsulates a cell's state.
public struct CellConfigurationState: ConfigurationState {
  // MARK - Managing View Configuration States

  /// The traits that describe the current layout environment of the view, such
  /// as the user interface style and layout direction.
  public var traitCollection: TraitCollection

  /// A boolean value that indicates whether the cell is in a selected state.
  public var isSelected: Bool = false

  /// A boolean value that indicates whether the cell is in a highlighted state.
  public var isHighlighted: Bool = false

  /// A boolean value that indicates whether the cell is in a focused state.
  public var isFocused: Bool = false

  /// A boolean value that indicates whether the cell is in a disabled state.
  public var isDisabled: Bool = false

  /// Accesses custom states by key.
  public subscript(key: ConfigurationStateCustomKey) -> AnyHashable? {
    get { return nil }
    set { }
  }

  // MARK - Creating a Configuration State Manually

  /// Creates a cell configuration state with the specified trait collection.
  public init(traitCollection: TraitCollection) {
    self.traitCollection = traitCollection
  }
}
