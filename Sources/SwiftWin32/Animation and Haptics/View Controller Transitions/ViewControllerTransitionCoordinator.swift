// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

public protocol ViewControllerTransitionCoordinator: ViewControllerTransitionCoordinatorContext {
  /// Responding to View Controller Transition Progress
  func animate(alongsideTransition animation: ((ViewControllerTransitionCoordinatorContext) -> Void)?,
               completion: ((ViewControllerTransitionCoordinatorContext) -> Void)?)
      -> Bool
  func animateAlongsideTransition(in view: View?,
                                  animation: ((ViewControllerTransitionCoordinatorContext) -> Void)?,
                                  completion: ((ViewControllerTransitionCoordinatorContext) -> Void)?)
      -> Bool
  func notifyWhenInteractionChanges(_ handler: @escaping (ViewControllerTransitionCoordinatorContext) -> Void)
}
