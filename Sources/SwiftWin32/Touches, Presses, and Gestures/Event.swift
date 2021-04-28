// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import struct Foundation.TimeInterval

extension Event {
  /// Specifies the general type of event.
  public enum EventType: Int {
    /// The event is related to touches on the screen.
    case touches

    /// The event is related to motion of the device.
    case motion

    /// The event is a remote-control event.
    case remoteControl

    /// The event is related to the press of a physical button.
    case presses
  }
}

extension Event {
  /// Specifies the subtype of the event in relation to its general type.
  public enum EventSubtype: Int {
    /// The event has no subtype.
    case none

    /// The event is related to the user shaking the device.
    case motionShake

    /// A remote-control event for playing audio or video.
    case remoteControlPlay
  }
}

extension Event {
  /// Set of buttons pressed for the current event
  public struct ButtonMask: OptionSet {
    public typealias RawValue = Int

    public let rawValue: RawValue

    // MARK - Creating Button Masks

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }

    /// Convenience initializer for a button mask where `buttonNumber` is a
    /// one-based index of the button on the input device
    public static func button(_ buttonNumber: Int) -> ButtonMask {
      ButtonMask(rawValue: 1 << (buttonNumber - 1))
    }

    // MARK - Accessing Button Masks

    public static var primary: ButtonMask {
      ButtonMask(rawValue: 1 << 0)
    }

    public static var secondary: ButtonMask {
      ButtonMask(rawValue: 1 << 1)
    }
  }
}

public class Event {
  // MARK - Getting Event Attributes

  /// The time when the event occurred.
  public var timestamp: TimeInterval

  internal init(timestamp: TimeInterval) {
    self.timestamp = timestamp
  }
}
