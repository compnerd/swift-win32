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

/// An object that describes a single user interaction with your app.
open class Event {
  // MARK - Getting the Touches for an Event

  /// Returns all touches associated with the event.
  open private(set) var allTouches: Set<Touch>?

  /// Returns the touch objects from the event that belong to the specified
  /// given view.
  open func touches(for view: View) -> Set<Touch>? {
    fatalError("\(#function) not yet implemented")
  }

  /// Returns the touch objects from the event that belong to the specified
  /// window.
  open func touches(for window: Window) -> Set<Touch>? {
    fatalError("\(#function) not yet implemented")
  }

  /// Returns all of the touches associated with the specified main touch.
  open func coalescedTouches(for touch: Touch) -> [Touch]? {
    fatalError("\(#function) not yet implemented")
  }

  /// Returns an array of touches that are predicted to occur for the specified
  /// touch.
  open func predictedTouches(for touch: Touch) -> [Touch]? {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Getting Event Attributes

  /// The time when the event occurred.
  open private(set) var timestamp: TimeInterval

  // MARK - Getting the Event Type

  /// Returns the type of the event.
  open private(set) var type: Event.EventType

  /// Returns the subtype of the event.
  open private(set) var subtype: Event.EventSubtype

  // MARK - Getting the Touches for a Gesture Recognizer

  /// Returns the touch objects that are being delivered to the specified
  /// gesture recognizer.
  open func touches(for gesture: GestureRecognizer) -> Set<Touch>? {
    fatalError("\(#function) not yet implemented")
  }

  ///
  open private(set) var buttonMask: Event.ButtonMask

  // MARK -

  ///
  open private(set) var modifierFlags: KeyModifierFlags

  // MARK -

  internal init(type: Event.EventType, subtype: Event.EventSubtype,
                timestamp: TimeInterval) {
    self.type = type
    self.subtype = subtype
    self.timestamp = timestamp
    self.buttonMask = []
    self.modifierFlags = []
  }
}
