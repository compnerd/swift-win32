// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A set of methods that vend objects used to manage a fixed-length or
/// interactive transition between view controllers.
public protocol ViewControllerTransitioningDelegate: AnyObject {
  // MARK - Getting the Transition Animator Objects

  /// Asks your delegate for the transition animator object to use when
  /// presenting a view controller.
  func animationController(forPresented presented: ViewController,
                           presenting: ViewController, source: ViewController)
      -> ViewControllerAnimatedTransitioning?

  /// Asks your delegate for the transition animator object to use when
  /// dismissing a view controller.
  func animationController(forDismissed dismissed: ViewController)
      -> ViewControllerAnimatedTransitioning?

  // MARK - Getting the Interactive Animator Objects

  /// Asks your delegate for the interactive animator object to use when
  /// presenting a view controller.
  func interactionControllerForPresentation(using animator: ViewControllerAnimatedTransitioning)
      -> ViewControllerInteractiveTransitioning?

  /// Asks your delegate for the interactive animator object to use when
  /// dismissing a view controller.
  func interactionControllerForDismissal(using animator: ViewControllerAnimatedTransitioning)
      -> ViewControllerInteractiveTransitioning?

  // MARK - Getting the Custom Presentation Controller

  /// Asks your delegate for the custom presentation controller to use for
  /// managing the view hierarchy when presenting a view controller.
  func presentationController(forPresented presented: ViewController,
                              presenting: ViewController?,
                              source: ViewController)
      -> PresentationController?
}

extension ViewControllerTransitioningDelegate {
  public func animationController(forPresented presented: ViewController,
                                  presenting: ViewController, source: ViewController)
      -> ViewControllerAnimatedTransitioning? {
    return nil
  }

  public func animationController(forDismissed dismissed: ViewController)
      -> ViewControllerAnimatedTransitioning? {
    return nil
  }
}

extension ViewControllerTransitioningDelegate {
  public func interactionControllerForPresentation(using animator: ViewControllerAnimatedTransitioning)
      -> ViewControllerInteractiveTransitioning? {
    return nil
  }

  public func interactionControllerForDismissal(using animator: ViewControllerAnimatedTransitioning)
      -> ViewControllerInteractiveTransitioning? {
    return nil
  }
}

extension ViewControllerTransitioningDelegate {
  public func presentationController(forPresented presented: ViewController,
                                     presenting: ViewController?,
                                     source: ViewController)
      -> PresentationController? {
    return nil
  }
}
