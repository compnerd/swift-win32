// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import struct Foundation.TimeInterval

/// An event that describes the state of a set of physical buttons that are
/// available to the device, such as those on an associated remote or game
/// controller.
open class PressesEvent: Event {
  // MARK - Reading the Event Button Presses

  /// Returns the state of all physical buttons in the event.
  open private(set) var allPresses: Set<Press>

  /// Returns the state of all physical buttons in the event that are associated
  /// with a particular gesture recognizer.
  open func presses(for guesture: GestureRecognizer) -> Set<Press> {
    fatalError("\(#function) not yet implemented")
  }

  // MARK -

  internal init(presses: Set<Press>, timestamp: TimeInterval) {
    self.allPresses = presses
    super.init(type: .presses, subtype: .none, timestamp: timestamp)
  }
}
