// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A discrete gesture recognizer that interprets single or multiple taps.
public class TapGestureRecognizer: GestureRecognizer {
  // MARK - Configuring the Gesture

  /// The bitmask of the buttons the user must press for gesture recognition.
  public var buttonMaskRequired: Event.ButtonMask = [.primary]

  /// The number of taps necessary for gesture recognition.
  public var numberOfTapsRequired: Int = 1

  /// The number of fingers that the user must tap for gesture recognition.
  public var numberOfTouchesRequired: Int = 1
}
