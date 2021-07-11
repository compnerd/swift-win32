// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.Scanner

/// A structure that specifies an amount to offset a position.
public struct Offset {
  // MARK - Initializing Offsets

  public init() {
    self = .zero
  }

  public init(horizontal: Double, vertical: Double) {
    self.horizontal = horizontal
    self.vertical = vertical
  }

  // MARK - Getting the Offset Values

  public private(set) var horizontal: Double

  public private(set) var vertical: Double
}

extension Offset: Equatable {
  public static func ==(_ lhs: Offset, _ rhs: Offset) -> Bool {
    return lhs.horizontal == rhs.horizontal && lhs.vertical == rhs.vertical
  }
}
extension Offset {
  /// Returns a string formatted to contain the data from an offset structure.
  public static func string(for offset: Offset) -> String {
    return String(format: "{%.17g, %.17g}", offset.horizontal, offset.vertical)
  }

  /// Returns an `Offset` structure corresponding to the data in a given string.
  ///
  /// In general, you should use this function only to convert strings that were
  // previously created using the `string(for:)` function.
  public static func offset(for string: String) -> Offset {
    let scanner: Scanner = Scanner(string: string)
    guard scanner.scanCharacter() == "{",
        let horizontal = scanner.scanDouble(),
        scanner.scanCharacter() == ",",
        let vertical = scanner.scanDouble(),
        scanner.scanCharacter() == "}" else {
      return .zero
    }
    return Offset(horizontal: horizontal, vertical: vertical)
  }
}

extension Offset {
  /// A `Offset` struct whose horizontal and vertical fields are set to the
  /// value 0.
  public static var zero: Offset {
    Offset(horizontal: 0.0, vertical: 0.0)
  }
}
