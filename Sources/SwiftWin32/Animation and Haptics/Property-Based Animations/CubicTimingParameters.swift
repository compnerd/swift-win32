// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if swift(>=5.7)
import CoreGraphics
#endif

/// The timing information for animations in the form of a cubic Bézier curve.
public class CubicTimingParameters {
  // MARK - Initializing a Cubic Timing Parameters Object

  /// Initializes the object with the system’s default timing curve.
  public init() {
    self.animationCurve = .linear
    self.controlPoint1 = .zero
    self.controlPoint2 = Point(x: 1, y: 1)
  }

  /// Initializes the object with the specified builtin timing curve.
  public init(animationCurve curve: View.AnimationCurve) {
    self.animationCurve = curve
    self.controlPoint1 = .zero
    self.controlPoint2 = .zero
  }

  /// Initializes the object with the specified control points for a cubic
  /// Bézier curve.
  public init(controlPoint1 point1: Point, controlPoint2 point2: Point) {
    self.animationCurve = .linear
    self.controlPoint1 = point1
    self.controlPoint2 = point2
  }

  // MARK - Getting the Timing Parameters

  /// The standard builtin animation curve to use for timing.
  public private(set) var animationCurve: View.AnimationCurve

  /// The first control point for the cubic Bézier curve.
  public private(set) var controlPoint1: Point

  /// The second control point of the cubic Bézier curve.
  public private(set) var controlPoint2: Point
}
