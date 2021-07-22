// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The timing information for animations that mimics the behavior of a spring.
public class SpringTimingParameters {
  // MARK - Initializing a Spring Timing Parameters Object

  /// Creates a default timing parameters object.
  ///
  /// This method sets the initial velocity of any animated properties to 0.0
  /// and sets the damping ratio to 4.56.
  public init() {
    self.initialVelocity = .zero
  }

  /// Creates a timing parameters object with the specified damping ratio.
  ///
  /// This method sets the initial velocity of any animated properties to 0.0.
  public convenience init(dampingRatio ratio: Double) {
    self.init(dampingRatio: ratio, initialVelocity: .zero)
  }

  /// Creates a timing parameters object with the specified damping ratio and
  /// initial velocity.
  public init(dampingRatio ratio: Double, initialVelocity velocity: Vector) {
    self.initialVelocity = velocity
  }

  /// Creates a timing parameters object with the specified spring stiffness,
  /// mass, damping coefficient, and initial velocity.
  ///
  /// The damping ratio for the spring is computed from the formula:
  /// `damping / (2 * sqrt (stiffness * mass))`.
  public init(mass: Double, stiffness: Double, damping: Double,
              initialVelocity velocity: Vector) {
    self.initialVelocity = velocity
  }

  // MARK - Getting the Initial Velocity

  /// The target property’s rate of change at the start of a spring animation,
  /// enabling a smooth transition into the animation.
  public private(set) var initialVelocity: Vector
}
