/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

private protocol ControlEventCallable {
  func callAsFunction(sender: Control, event: Control.Event)
}

private struct ControlEventCallback<Source: Control, Target: AnyObject>: ControlEventCallable {
  private unowned(safe) let instance: Target
  private let method: (Target) -> (_: Source, _: Control.Event) -> Void

  public init(binding: @escaping (Target) -> (_: Source, _: Control.Event) -> Void,
              on: Target) {
    self.instance = on
    self.method = binding
  }

  public init(binding: @escaping (Target) -> (_: Source) -> Void, on: Target) {
    self.instance = on
    self.method = { (target: Target) in { (sender: Source, _: Control.Event) in
        binding(target)(sender)
      }
    }
  }

  public init(binding: @escaping (Target) -> () -> Void, on: Target) {
    self.instance = on
    self.method = { (target: Target) in { (_: Source, _: Control.Event) in
        binding(target)()
      }
    }
  }

  public func callAsFunction(sender: Control, event: Control.Event) {
    self.method(instance)(sender as! Source, event)
  }
}

public class Control: View {
  private var actions: [Control.Event:[ControlEventCallable]] =
      Dictionary<Control.Event, [ControlEventCallable]>(minimumCapacity: 16)

  /// Accessing the Control's Targets and Actions
  public let allControlEvents: Control.Event = Control.Event(rawValue: 0)

  @inline(__always)
  private func addAction(_ callable: ControlEventCallable,
                         for controlEvents: Control.Event) {
    for event in Control.Event.touchEvents + Control.Event.semanticEvents + Control.Event.editingEvents {
      if controlEvents.rawValue & event.rawValue == event.rawValue {
        self.actions[event, default: []].append(callable)
      }
    }
  }

  public func addTarget<Target: AnyObject>(_ target: Target,
                                           action: @escaping (Target) -> () -> Void,
                                           for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback<Self, Target>(binding: action, on: target),
                   for: controlEvents)
  }

  public func addTarget<Source: Control, Target: AnyObject>(_ target: Target,
                                                            action: @escaping (Target) -> (_: Source) -> Void,
                                                            for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback(binding: action, on: target),
                   for: controlEvents)
  }

  public func addTarget<Source: Control, Target: AnyObject>(_ target: Target,
                                                            action: @escaping (Target) -> (_: Source, _: Control.Event) -> Void,
                                                            for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback<Source, Target>(binding: action, on: target),
                   for: controlEvents)
  }

  /// Triggering Actions
  func sendActions(for controlEvents: Control.Event) {
    for event in Control.Event.touchEvents + Control.Event.semanticEvents + Control.Event.editingEvents {
      if controlEvents.rawValue & event.rawValue == event.rawValue {
        _ = self.actions[event]?.map { $0(sender: self, event: controlEvents) }
      }
    }
  }
}

public extension Control {
  struct State: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
  }
}

public extension Control.State {
  static let normal: Control.State = Control.State(rawValue: 1 << 0)
  static let highlighted: Control.State = Control.State(rawValue: 1 << 1)
  static let disabled: Control.State = Control.State(rawValue: 1 << 2)
  static let selected: Control.State = Control.State(rawValue: 1 << 3)
  static let focused: Control.State = Control.State(rawValue: 1 << 4)
  static let application: Control.State = Control.State(rawValue: 1 << 5)
  static let reserved: Control.State = Control.State(rawValue: 1 << 6)
}

extension Control {
  public struct Event: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Control.Event {
  public static let touchDown: Control.Event =
      Control.Event(rawValue: 1 << 0)
  public static let touchDownRepeat: Control.Event =
      Control.Event(rawValue: 1 << 1)
  public static let touchDragInside: Control.Event =
      Control.Event(rawValue: 1 << 2)
  public static let touchDragOutside: Control.Event =
      Control.Event(rawValue: 1 << 3)
  public static let touchDragEnter: Control.Event =
      Control.Event(rawValue: 1 << 4)
  public static let touchDragExit: Control.Event =
      Control.Event(rawValue: 1 << 5)
  public static let touchUpInside: Control.Event =
      Control.Event(rawValue: 1 << 6)
  public static let touchUpOutside: Control.Event =
      Control.Event(rawValue: 1 << 7)
  public static let touchCancel: Control.Event =
      Control.Event(rawValue: 1 << 8)

  public static let valueChanged: Control.Event =
      Control.Event(rawValue: 1 << 12)
  public static let menuActionTriggered: Control.Event =
      Control.Event(rawValue: 0)
  public static let primaryActionTriggered: Control.Event =
      Control.Event(rawValue: 1 << 13)

  public static let editingDidBegin: Control.Event =
      Control.Event(rawValue: 1 << 16)
  public static let editingChanged: Control.Event =
      Control.Event(rawValue: 1 << 17)
  public static let editingDidEnd: Control.Event =
      Control.Event(rawValue: 1 << 18)
  public static let editingDidEndOnExit: Control.Event =
      Control.Event(rawValue: 1 << 19)

  public static let allTouchEvents: Control.Event =
      Control.Event(rawValue: 0x00000fff)
  public static let allEditingEvents: Control.Event =
      Control.Event(rawValue: 0x000f0000)

  public static let applicationReserved: Control.Event =
      Control.Event(rawValue: 0x0f000000)
  public static let systemReserved: Control.Event =
      Control.Event(rawValue: 0xf0000000)

  public static let allEvents: Control.Event =
      Control.Event(rawValue: 0xffffffff)
}

extension Control.Event {
  fileprivate static var touchEvents: [Control.Event] {
    return [
        .touchDown, .touchDownRepeat,
        .touchDragInside, .touchDragOutside, .touchDragEnter, .touchDragExit,
        .touchUpInside, .touchUpOutside,
        .touchCancel
    ]
  }

  fileprivate static var semanticEvents: [Control.Event] {
    return [
      .valueChanged, /* .menuActionTriggered, */ .primaryActionTriggered
    ]
  }

  fileprivate static var editingEvents: [Control.Event] {
    return [
        .editingDidBegin, .editingChanged, .editingDidEnd, .editingDidEndOnExit
    ]
  }
}
