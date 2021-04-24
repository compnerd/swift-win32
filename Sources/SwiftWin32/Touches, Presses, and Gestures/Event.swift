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

public class Event {
  /// Getting Event Attributes

  /// The time when the event occurred.
  public var timestamp: TimeInterval

  internal init(timestamp: TimeInterval) {
    self.timestamp = timestamp
  }
}
