// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// Constants indicating the type of timing information to use.
public enum TimingCurveType: Int {
  /// Use the built-in timing curves. Specify this value when you want to use
  /// one of the constants in the `View.AnimationCurve` type. Specify the
  /// desired curve using the `cubicTimingParameters` property.
  case builtin

  /// Use a custom cubic Bézier curve. Specify the curve information using the
  /// `cubicTimingParameters` property.
  case cubic

  /// Use a custom spring animation. Specify the desired curve using the
  /// `springTimingParameters` property.
  case spring

  /// Use a combination of timing parameters. This type of curve starts with the
  /// curve defined by the `cubicTimingParameters` property and modifies it
  /// using the spring information in the `springTimingParameters` property.
  case composed
}

/// An interface for providing the timing information needed to perform
/// animations.
public protocol TimingCurveProvider {
  // MARK - Getting the Timing Information

  /// The type of timing information to use.
  var timingCurveType: TimingCurveType { get }

  /// The cubic timing parameters to use.
  var cubicTimingParameters: CubicTimingParameters? { get }

  /// The spring-based timing parameters to use.
  var springTimingParameters: SpringTimingParameters? { get }
}
