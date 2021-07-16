// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A set of methods that, in conjunction with a presentation controller,
/// determine how to respond to trait changes in your application.
public protocol AdaptivePresentationControllerDelegate: AnyObject {
  // MARK - Adapting the Presentation Style

  /// Asks the delegate for the presentation style to use when the specified set
  /// of traits are active.
  ///
  /// The presentation controller calls this method when the traits of the
  /// current environment are about to change. Your implementation of this
  /// method can return the preferred presentation style to use for the
  /// specified traits. If you do not return one of the allowed styles, the
  /// presentation controller uses its preferred default style.
  ///
  /// If you do not implement this method in your delegate, the framework calls
  /// the `adaptivePresentationStyle(for:)` method instead.
  func adaptivePresentationStyle(for controller: PresentationController,
                                 traitCollection: TraitCollection)
      -> ModalPresentationStyle

  /// Asks the delegate for the new presentation style to use.
  ///
  /// Use the `adaptivePresentationStyle(for:traitCollection:)` method to handle
  /// all trait changes instead of this method. If you do not implement that
  /// method, you can use this method to change the presentation style when
  /// transitioning to a horizontally compact environment.
  ///
  /// If you do not implement this method or if you return an invalid style, the
  /// current presentation controller returns its preferred default style.
  func adaptivePresentationStyle(for controller: PresentationController)
      -> ModalPresentationStyle

  // MARK - Adapting the View Controller

  /// Asks the delegate for the view controller to display when adapting to the
  /// specified presentation style.
  ///
  /// When a size class change causes a change to the underlying presentation
  /// style, the presentation controller calls this method to ask for the view
  /// controller to display in that new style. This method is your opportunity
  /// to replace the current view controller with one that is better suited for
  /// the new presentation style. For example, you might use this method to
  /// insert a navigation controller into your view hierarchy to facilitate
  /// pushing new view controllers more easily in the compact environment. In
  /// that instance, you would return a navigation controller whose root view
  /// controller is the currently presented view controller. You could also
  /// return an entirely different view controller if you prefer.
  ///
  /// If you do not implement this method or your implementation returns `nil`,
  /// the presentation controller uses its existing presented view controller.
  func presentationController(_ controller: PresentationController,
                              viewControllerForAdaptivePresentationStyle style: ModalPresentationStyle)
      -> ViewController?

  // MARK - Responding to Adaptive Transitions

  /// Notifies the delegate that an adaptivity-related transition is about to
  /// occur.
  ///
  /// When a size class change occurs, the framework calls this method to let
  /// you know how the presentation controller will adapt. Use this method to
  /// make any additional changes. For example, you might use the transition
  /// coordinator object to create additional animations for the transition.
  func presentationController(_ presentationController: PresentationController,
                              willPresentWithAdaptiveStyle style: ModalPresentationStyle,
                              transitionCoordinator: ViewControllerTransitionCoordinator?)

  /// Notifies the delegate that a user-initiated attempt to dismiss a view was
  /// prevented.
  ///
  /// The framework supports refusing to dismiss a presentation when the
  /// `presentationController.isModalInPresentation` returns `true` or
  /// `presentationControllerShouldDismiss(_:)` returns `false`.
  ///
  /// Use this method to inform the user why the presentation can't be
  /// dismissed, for example, by presenting an instance of `AlertController`.
  func presentationControllerDidAttemptToDismiss(_ presentationController: PresentationController)

  /// Asks the delegate for permission to dismiss the presentation.
  ///
  /// The system may call this method at any time. This method isn't guaranteed
  /// to be followed by a call to `presentationControllerWillDismiss(_:)` or
  /// `presentationControllerDidDismiss(_:)`. Make sure that your implementation
  /// of this method returns quickly.
  func presentationControllerShouldDismiss(_ presentationController: PresentationController)
      -> Bool

  /// Notifies the delegate after a presentation is dismissed.
  ///
  /// This method is not called if the presentation is dismissed
  /// programmatically.
  func presentationControllerDidDismiss(_ presentationController: PresentationController)

  /// Notifies the delegate before a presentation is dismissed.
  ///
  /// You can use this method to set up animations or interaction notifications
  /// with the `presentationController`'s `transitionCoordinator`.
  ///
  /// This method is not called if the presentation is dismissed
  /// programmatically.
  func presentationControllerWillDismiss(_ presentationController: PresentationController)

  // MARK - Preparing the Adaptive Presentation Controller

  /// Provides an opportunity to configure the adaptive presentation controller
  /// after an adaptivity change.
  ///
  /// The system calls this method during adaptation so the delegate can
  /// configure properties of the adaptive presentation controller before it
  /// presents.
  ///
  /// For example, the system automatically adapts a view controller that
  /// presents as a popover in standard size classes to a sheet in compact size
  /// classes. You can implement this method to customize the sheet's
  /// properties before it presents.
  func presentationController(_ presentationController: PresentationController,
                              prepare adaptivePresentationController: PresentationController)
}

extension AdaptivePresentationControllerDelegate {
  public func adaptivePresentationStyle(for controller: PresentationController,
                                        traitCollection: TraitCollection)
      -> ModalPresentationStyle {
    return self.adaptivePresentationStyle(for: controller)
  }

  public func adaptivePresentationStyle(for controller: PresentationController)
      -> ModalPresentationStyle {
    return controller.presentationStyle
  }
}

extension AdaptivePresentationControllerDelegate {
  public func presentationController(controller: PresentationController,
                                     viewControllerForAdaptivePresentationStyle style: ModalPresentationStyle)
      -> ViewController? {
    return controller.presentedViewController
  }
}

extension AdaptivePresentationControllerDelegate {
  public func presentationController(_ controller: PresentationController,
                                     willPresentWithAdaptiveStyle style: ModalPresentationStyle,
                                     transitionCoordinator: ViewControllerTransitionCoordinator?) {
  }

  public func presentationControllerDidAttemptToDismiss(_ presentationController: PresentationController) {
  }

  public func presentationControllerShouldDismiss(_ presentationController: PresentationController) -> Bool {
    return true
  }

  public func presentationControllerDidDismiss(_ presentationController: PresentationController) {
  }

  public func presentationControllerWillDismiss(_ presentationController: PresentationController) {
  }
}

extension AdaptivePresentationControllerDelegate {
  public func presentationController(_ presentationController: PresentationController,
                                     prepare adaptivePresentationController: PresentationController) {
  }
}
