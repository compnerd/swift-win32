// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import struct Foundation.TimeInterval

extension Touch {
  /// The type of touch received.
  public enum TouchType: Int {
  /// A touch resulting from direct contact with the screen.
  case direct
  /// A touch that did not result from direct contact with the screen.
  case indirect
  /// A touch from a stylus.
  case pencil
  }
}

extension Touch {
  /// The phase of a touch event.
  public enum Phase: Int {
  /// A touch for a given event has pressed down on the screen.
  case began
  /// A touch for a given event has moved over the screen.
  case moved
  /// A touch for a given event is presseddown on the screen, but hasn't moved
  /// since the previous event.
  case stationary
  /// A touch for a given event has lifted from the screen.
  case ended
  /// The system cancelled tracking for a touch, for example, when the user
  /// moves the device against their face.
  case cancelled
  /// A touch for a given event has entered a window on the screen.
  case regionEntered
  /// A touch for the given event is within a window on the screen, but has not
  /// yet pressed down.
  case regionMoved
  /// A touch for given event has left a window on the screen.
  case regionExited
  }
}

/// An object representing the location, size, movement, and force of a touch
/// occurring on the screen.
public class Touch {
  /// Getting the Location of a Touch

  /// The view to which touches are being delivered, if any.
  public let view: View?

  /// Getting Touch Attriutes

  /// The time when the touch occurred or when it was last mutated.
  public let timestamp: TimeInterval

  internal init(for view: View?, at time: TimeInterval) {
    self.view = view
    self.timestamp = time
  }
}

extension Touch: Hashable {
  public static func ==(_ lhs: Touch, _ rhs: Touch) -> Bool {
    return lhs.view == rhs.view && lhs.timestamp == rhs.timestamp
  }

  public func hash(into hasher: inout Hasher) {
    // TODO(compnerd) figure out how to hash a Touch
  }
}
