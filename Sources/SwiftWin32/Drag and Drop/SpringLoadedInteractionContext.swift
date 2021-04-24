// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The spring-loaded interaction states that determine the style of the
/// interaction view.
public enum SpringLoadedInteractionEffectState: Int {
/// An interaction state that indicates that the view was spring loaded.
case activated
/// An interaction state that indicates that spring loading is about to start.
case activating
/// An interaction state that indicates that spring loading is not engaged.
case inactive
/// An interaction state that indicates that spring loading is available.
case possible
}

/// The interface an object implements to provide information about a
/// spring-loaded interaction.
public protocol SpringLoadedInteractionContext {
  /// The current view style for the string-loaded interaction.
  var state: SpringLoadedInteractionEffectState { get }

  /// The specific subview, or associated model object, of the target view to
  /// use for the spring-loaded interaction.
  var targetItem: Any? { get set }

  /// The view to which the current spring-loaded interaction view style is
  /// applied.
  var targetView: View? { get set }
}
