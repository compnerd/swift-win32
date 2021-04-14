/**
 * Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A set of methods implemented by the delegate of a gesture recognizer to
/// fine-tune an application’s gesture-recognition behavior.
public protocol GestureRecognizerDelegate: AnyObject {
  // MARK - Regulating Gesture Recognition

  /// Asks the delegate if a gesture recognizer should begin interpreting
  /// touches.
  func gestureRecognizerShouldBegin(_ gestureRecognizer: GestureRecognizer)
      -> Bool

  /// Asks the delegate if a gesture recognizer should receive an object
  /// representing a touch.
  func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldReceive touch: Touch) -> Bool

  /// Asks the delegate if a gesture recognizer should receive an object
  /// representing a press.
#if NOT_YET_IMPLEMENTED
  func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldReceive press: Press) -> Bool
#endif

  /// Asks the delegate if a gesture recognizer should receive an object
  /// representing a touch or press event.
  func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldReceive event: Event) -> Bool

  // MARK - Controlling Simultaneous Gesture Recognition

  /// Asks the delegate if two gesture recognizers should be allowed to
  /// recognize gestures simultaneously.
  func gestureRecognizer(_ gestureRecognizer: GestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: GestureRecognizer)
      -> Bool

  // MARK - Setting Up Failure Requirements

  /// Asks the delegate if a gesture recognizer should require another gesture
  /// recognizer to fail.
  func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldRequireFailureOf otherGestureRecognizer: GestureRecognizer)
      -> Bool

  /// Asks the delegate if a gesture recognizer should be required to fail by
  /// another gesture recognizer.
  func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldBeRequiredToFailBy otherGestureRecognizer: GestureRecognizer)
      -> Bool
}

extension GestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: GestureRecognizer)
      -> Bool {
    return true
  }

  public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                                shouldReceive touch: Touch) -> Bool {
    return true
  }

#if NOT_YET_IMPLEMENTED
  public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer,
                                shouldReceive press: Press) -> Bool {
    return true
  }
#endif

  public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                                shouldReceive event: Event) -> Bool {
    return true
  }
}

extension GestureRecognizerDelegate {
  public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer,
                                shouldRecognizeSimultaneouslyWith otherGestureRecognizer: GestureRecognizer)
      -> Bool {
    return false
  }
}

extension GestureRecognizerDelegate {
  public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                                shouldRequireFailureOf otherGestureRecognizer: GestureRecognizer)
      -> Bool {
    return false
  }

  public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                                shouldBeRequiredToFailBy otherGestureRecognizer: GestureRecognizer)
      -> Bool {
    return false
  }
}
