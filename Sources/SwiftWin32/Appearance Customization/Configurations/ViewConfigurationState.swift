/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A structure that encapsulates a view's state.
public struct ViewConfigurationState: ConfigurationState {
  // MARK - Managing View Configuration States

  /// The traits that describe the current layout environment of the view, such
  /// as the user interface style and layout direction.
  public var traitCollection: TraitCollection

  /// A boolean value that indicates whether the view is in a selected state.
  public var isSelected: Bool

  /// A boolean value that indicates whether the view is in a highlighted state.
  public var isHighlighted: Bool

  /// A boolean value that indicates whether the view is in a focused state.
  public var isFocused: Bool

  /// A boolean value that indicates whether the view is in a disabled state.
  public var isDisabled: Bool

  /// Accesses custom states by key.
  public subscript(key: ConfigurationStateCustomKey) -> AnyHashable? {
    get { fatalError("\(#function) not yet implemented") }
    set { fatalError("\(#function) not yet implemented") }
  }

  // MARK - Creating a Configuration State Manually

  public init(traitCollection: TraitCollection) {
    self.traitCollection = traitCollection

    self.isSelected = false
    self.isHighlighted = false
    self.isFocused = false
    self.isDisabled = false
  }
}

extension ViewConfigurationState: Hashable {
  public static func ==(_ lhs: ViewConfigurationState,
                        _ rhs: ViewConfigurationState) -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  public func hash(into hasher: inout Hasher) {
    fatalError("\(#function) not yet implemented")
  }
}

extension ViewConfigurationState: CustomStringConvertible {
  public var description: String {
    fatalError("\(#function) not yet implemented")
  }
}

extension ViewConfigurationState: CustomDebugStringConvertible {
  public var debugDescription: String {
    fatalError("\(#function) not yet implemented")
  }
}

extension ViewConfigurationState: CustomReflectable {
  public var customMirror: Mirror {
    fatalError("\(#function) not yet implemented")
  }
}
