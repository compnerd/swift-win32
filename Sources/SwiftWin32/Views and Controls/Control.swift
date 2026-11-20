// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

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

extension ControlEventCallback where Target: Action {
  fileprivate init(invoking action: Target) {
    self.instance = action
    self.method = { (_: Target) in { (sender: Source, _: Control.Event) in
        action.sender = sender
        defer { action.sender = nil }
        action.handler(action)
      }
    }
  }
}

@inline(__always)
private var kTriggers: [Control.Event] {
  Control.Event.touchEvents + Control.Event.semanticEvents + Control.Event.editingEvents
}

/// The base class for controls, which are visual elements that convey a
/// specific action or intention in response to user interactions.
public class Control: View {
  private var actions: [Control.Event:[ControlEventCallable]] =
      Dictionary<Control.Event, [ControlEventCallable]>(minimumCapacity: 16)

  // MARK - Accessing the Control's Targets and Actions

  @inline(__always)
  private func addAction(_ callable: ControlEventCallable,
                         for controlEvents: Control.Event) {
    kTriggers.filter { $0.rawValue & controlEvents.rawValue == $0.rawValue }
             .forEach { self.actions[$0, default: []].append(callable) }
  }

  internal func addAction(_ action: Action, for controlEvents: Control.Event) {
    kTriggers.filter { $0.rawValue & controlEvents.rawValue == $0.rawValue }
             .forEach { self.actions[$0, default: []].append(ControlEventCallback(invoking: action)) }
  }

  /// Associates a target object and action method with the control.
  public func addTarget<Target: AnyObject>(_ target: Target,
                                           action: @escaping (Target) -> () -> Void,
                                           for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback<Self, Target>(binding: action, on: target),
                   for: controlEvents)
  }

  /// Associates a target object and action method with the control.
  public func addTarget<Source: Control, Target: AnyObject>(_ target: Target,
                                                            action: @escaping (Target) -> (_: Source) -> Void,
                                                            for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback(binding: action, on: target),
                   for: controlEvents)
  }

  /// Returns the events for which the control has associated actions.
  public private(set) var allControlEvents: Control.Event =
      Control.Event(rawValue: 0)

  /// Associates a target object and action method with the control.
  public func addTarget<Source: Control, Target: AnyObject>(_ target: Target,
                                                            action: @escaping (Target) -> (_: Source, _: Control.Event) -> Void,
                                                            for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback<Source, Target>(binding: action, on: target),
                   for: controlEvents)
  }

  // MARK - Triggering Actions

  /// Calls the action methods associated with the specified events.
  func sendActions(for controlEvents: Control.Event) {
    kTriggers.filter { $0.rawValue & controlEvents.rawValue == $0.rawValue }
             .forEach { self.actions[$0]?.forEach { $0(sender: self, event: controlEvents) } }
  }
}

public extension Control {
  /// The state of the control, specified as a bit mask value.
  struct State: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
  }
}

public extension Control.State {
  /// The normal, or default state of a control—that is, enabled but neither
  /// selected nor highlighted.
  static var normal: Control.State {
    Control.State(rawValue: 1 << 0)
  }

  /// Highlighted state of a control.
  static var highlighted: Control.State {
    Control.State(rawValue: 1 << 1)
  }

  /// Disabled state of a control.
  static var disabled: Control.State {
    Control.State(rawValue: 1 << 2)
  }

  /// Selected state of a control.
  static var selected: Control.State {
    Control.State(rawValue: 1 << 3)
  }

  /// Focused state of a control.
  static var focused: Control.State {
    Control.State(rawValue: 1 << 4)
  }

  /// Additional control-state flags available for application use.
  static var application: Control.State {
    Control.State(rawValue: 1 << 5)
  }

  /// Control-state flags reserved for internal framework use.
  static var reserved: Control.State {
    Control.State(rawValue: 1 << 6)
  }
}

extension Control {
  /// Constants describing the types of events possible for controls.
  public struct Event: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Control.Event {
  /// A touch-down event in the control.
  public static var touchDown: Control.Event {
    Control.Event(rawValue: 1 << 0)
  }

  /// A repeated touch-down event in the control; for this event the value of
  /// the UITouch tapCount method is greater than one.
  public static var touchDownRepeat: Control.Event {
    Control.Event(rawValue: 1 << 1)
  }

  /// An event where a finger is dragged inside the bounds of the control.
  public static var touchDragInside: Control.Event {
    Control.Event(rawValue: 1 << 2)
  }

  /// An event where a finger is dragged just outside the bounds of the control.
  public static var touchDragOutside: Control.Event {
    Control.Event(rawValue: 1 << 3)
  }

  /// An event where a finger is dragged into the bounds of the control.
  public static var touchDragEnter: Control.Event {
    Control.Event(rawValue: 1 << 4)
  }

  /// An event where a finger is dragged from within a control to outside its
  /// bounds.
  public static var touchDragExit: Control.Event {
    Control.Event(rawValue: 1 << 5)
  }

  /// A touch-up event in the control where the finger is inside the bounds of
  /// the control.
  public static var touchUpInside: Control.Event {
    Control.Event(rawValue: 1 << 6)
  }

  /// A touch-up event in the control where the finger is outside the bounds of
  /// the control.
  public static var touchUpOutside: Control.Event {
    Control.Event(rawValue: 1 << 7)
  }

  /// A system event canceling the current touches for the control.
  public static var touchCancel: Control.Event {
    Control.Event(rawValue: 1 << 8)
  }

  /// A touch dragging or otherwise manipulating a control, causing it to emit
  /// a series of different values.
  public static var valueChanged: Control.Event {
    Control.Event(rawValue: 1 << 12)
  }

  /// A menu action has triggered prior to the menu being presented.
  public static var menuActionTriggered: Control.Event {
    Control.Event(rawValue: 0)
  }

  /// A semantic action triggered by buttons.
  public static var primaryActionTriggered: Control.Event {
    Control.Event(rawValue: 1 << 13)
  }

  /// A touch initiating an editing session in a `TextField` object by entering
  /// its bounds.
  public static var editingDidBegin: Control.Event {
    Control.Event(rawValue: 1 << 16)
  }

  /// A touch making an editing change in a `TextField` object.
  public static var editingChanged: Control.Event {
    Control.Event(rawValue: 1 << 17)
  }

  /// A touch ending an editing session in a `TextField` object by leaving its
  /// bounds.
  public static var editingDidEnd: Control.Event {
    Control.Event(rawValue: 1 << 18)
  }

  /// A touch ending an editing session in a `TextField` object.
  public static var editingDidEndOnExit: Control.Event {
    Control.Event(rawValue: 1 << 19)
  }

  /// All touch events.
  public static var allTouchEvents: Control.Event {
    Control.Event(rawValue: RawValue(bitPattern: 0x00000fff))
  }

  /// All editing touches for `TextField` objects.
  public static var allEditingEvents: Control.Event {
    Control.Event(rawValue: RawValue(bitPattern: 0x000f0000))
  }

  /// A range of control-event values available for application use.
  public static var applicationReserved: Control.Event {
    Control.Event(rawValue: RawValue(bitPattern: 0x0f000000))
  }

  /// A range of control-event values reserved for internal framework use.
  public static var systemReserved: Control.Event {
    Control.Event(rawValue: RawValue(bitPattern: 0xf0000000))
  }

  /// All events, including system events.
  public static var allEvents: Control.Event {
    Control.Event(rawValue: RawValue(bitPattern: 0xffffffff))
  }
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
