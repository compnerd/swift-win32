// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

// Class constrain the callable to ensure that the value is heap allocated,
// permitting us to perform pointer equality for the callback to serve as
// identity.  Using COW, we can perform pointer equality on the types as a
// rough equivalency for the pointer equality for the bound action, which
// determines if the action is equivalent or not.
private protocol GestureRecognizerCallable: AnyObject {
  func callAsFunction(_: GestureRecognizer)
}

private class GestureRecognizerCallback<Target: AnyObject>: GestureRecognizerCallable {
  private enum Signature {
  case zero((Target) -> () -> Void)
  case one((Target) -> (_: GestureRecognizer) -> Void)
  }

  private unowned(unsafe) let instance: Target
  private let method: Signature

  public init(binding: @escaping (Target) -> (GestureRecognizer) -> Void, on: Target) {
    self.instance = on
    self.method = .one(binding)
  }

  public init(binding: @escaping (Target) -> () -> Void, on: Target) {
    self.instance = on
    self.method = .zero(binding)
  }

  public func callAsFunction(_ gestureRecognizer: GestureRecognizer) {
    switch self.method {
    case let .zero(action):
      action(self.instance)()
    case let .one(action):
      action(self.instance)(gestureRecognizer)
    }
  }
}

public class GestureRecognizer {
  private var actions: [GestureRecognizerCallable]

  // MARK - Initializing a Gesture Recognizer

  /// Initializes an allocated gesture-recognizer object with a target and an
  /// action selector.
  ///
  /// The valid signatures for `action` are:
  ///   - `(Target) -> () -> Void` aka `()`
  ///   - `(Target) -> (_: GestureRecognizer) -> Void` aka `(_: GestureRecognizer)`
  ///
  /// Although the signature permits nullable types, the values may not be nil.

  // public init(target: Any?, action: Selector?)

  public init<Target: AnyObject>(target: Target,
                                 action: @escaping (Target) -> () -> Void) {
    self.actions = [GestureRecognizerCallback(binding: action, on: target)]
  }

  public init<Target: AnyObject>(target: Target,
                                 action: @escaping (Target) -> (_: GestureRecognizer) -> Void) {
    self.actions = [GestureRecognizerCallback(binding: action, on: target)]
  }

  // MARK - Managing Gesture-Related Interactions

  /// The delegate of the gesture recognizer.
  public weak var delegate: GestureRecognizerDelegate?

  // MARK - Adding and Removing Targets and Actions

  /// Adds a target and an action to a gesture-recognizer object.
  ///
  /// The valid signatures for `action` are:
  ///   - `(Target) -> () -> Void` aka `()`
  ///   - `(Target) -> (_: GestureRecognizer) -> Void` aka `(_: GestureRecognizer)`

  // public func addTarget(_ target: Any, action: Selector)

  public func addTarget<Target: AnyObject>(_ target: Target,
                                           action: @escaping (Target) -> () -> Void) {
    self.actions.append(GestureRecognizerCallback(binding: action, on: target))
  }

  public func addTarget<Target: AnyObject>(_ target: Target,
                                           action: @escaping (Target) -> (_: GestureRecognizer) -> Void) {
    self.actions.append(GestureRecognizerCallback(binding: action, on: target))
  }

  /// Removes a target and an action from a gesture-recognizer object.

  // public func removeTarget(_ target: Any?, action: Selector?)

  public func removeTarget<Target: AnyObject>(_ target: Target,
                                              action: @escaping (Target) -> () -> Void) {
    let callable: GestureRecognizerCallable =
        GestureRecognizerCallback(binding: action, on: target)
    self.actions.removeAll(where: { $0 === callable })
  }

  public func removeTarget<Target: AnyObject>(_ target: Target,
                                              action: @escaping (Target) -> (_: GestureRecognizer) -> Void) {
    let callable: GestureRecognizerCallable =
        GestureRecognizerCallback(binding: action, on: target)
    self.actions.removeAll(where: { $0 === callable })
  }

  // MARK - Getting the Touches and Location of a Gesture

  /// Returns the point computed as the location in a given view of the gesture
  /// represented by the receiver.
  public func location(in view: View?) -> Point {
    fatalError("\(#function) not yet implemented")
  }

  /// Returns the location of one of the gesture’s touches in the local
  /// coordinate system of a given view.
  public func location(ofTouch touchIndex: Int, in view: View?) -> Point {
    fatalError("\(#function) not yet implemented")
  }

  /// Returns the number of touches involved in the gesture represented by the
  /// receiver.
  public private(set) var numberOfTouches: Int = 0

  // MARK - Debugging Gesture Recognizers

  /// The name associated with the gesture recognizer.
  public var name: String?

  // MARK - Constants

  /// The current state a gesture recognizer is in.
  public enum State: Int {
  /// The gesture recognizer has not yet recognized its gesture, but may be
  /// evaluating touch events. This is the default state.
  case possible

  /// The gesture recognizer has received touch objects recognized as a
  /// continuous gesture. It sends its action message (or messages) at the next
  /// cycle of the run loop.
  case began

  /// The gesture recognizer has received touches recognized as a change to a
  /// continuous gesture. It sends its action message (or messages) at the next
  /// cycle of the run loop.
  case changed

  /// The gesture recognizer has received touches recognized as the end of a
  /// continuous gesture. It sends its action message (or messages) at the next
  /// cycle of the run loop and resets its state to
  /// `GestureRecognizer.State.possible`.
  case ended

  /// The gesture recognizer has received touches resulting in the cancellation
  /// of a continuous gesture. It sends its action message (or messages) at the
  /// next cycle of the run loop and resets its state to
  /// `GestureRecognizer.State.possible`.
  case cancelled

  /// The gesture recognizer has received a multi-touch sequence that it cannot
  /// recognize as its gesture. No action message is sent and the gesture
  /// recognizer is reset to `GestureRecognizer.State.possible`.
  case failed
  }

  // MARK - Initializers

  public /* convenience */ init() {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Instance Methods

  public func shouldReceive(_ event: Event) -> Bool {
    fatalError("\(#function) not yet implemented")
  }
}

extension GestureRecognizer.State {
  /// The gesture recognizer has received a multi-touch sequence that it
  /// recognizes as its gesture. It sends its action message (or messages) at
  /// the next cycle of the run loop and resets its state to
  /// `GestureRecognizer.State.possible`.
  public static var recognized: GestureRecognizer.State {
    .ended
  }
}
