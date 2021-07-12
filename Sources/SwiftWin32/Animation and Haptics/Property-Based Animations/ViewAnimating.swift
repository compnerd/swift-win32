// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// All rights reserved.

/// Constants indicating positions within the animation.
public enum ViewAnimatingPosition: Int {
  /// The end point of the animation. Use this constant when you want the final
  /// values for any animatable properties — that is, you want to refer to the
  /// values you specified in your animation blocks.
  case end

  /// The beginning of the animation. Use this constant when you want the
  /// starting values for any animatable properties—that is, the values of the
  /// properties before you applied any animations.
  case start

  /// The current position. Use this constant when you want the most recent
  /// value set by an animator object.
  case current
}
