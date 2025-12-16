// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The methods adopted by the object you use to manage changes to a split view
/// interface.
public protocol SplitViewControllerDelegate: AnyObject {
  // MARK - Specifying the Interface Orientations

  /// Asks the delegate for the orientation to use when presenting the split
  /// view controller.
  ///
  /// The framework calls this method to determine which orientation your app
  /// prefers when presenting the specified split view controller. You can use
  /// this method to specify the orientation that you think is best when first
  /// displaying the split view controller. The orientation you specify can be
  /// different from the current device orientation. After presentation, the
  /// system may rotate the split view controller as appropriate to one of its
  /// other supported interface orientations.
  ///
  /// If you do not implement this method, the system presents the view
  /// controller using the current orientation of the status bar.
  func splitViewControllerPreferredInterfaceOrientationForPresentation(_ splitViewController: SplitViewController)
      -> InterfaceOrientation

  /// Asks the delegate to specify the interface orientations that the split
  /// view controller supports.
  ///
  /// The split view controller calls this method to obtain the orientations
  /// that it supports. You can use this method to alter the set of
  /// orientations typically supported by a split view controller. If you don't
  /// implement this method, the split view controller supports all
  /// orientations.
  func splitViewControllerSupportedInterfaceOrientations(_ splitViewController: SplitViewController)
      -> InterfaceOrientationMask

  // MARK - Responding to Display Mode Changes

  /// Tells the delegate that the display mode for the split view controller is
  /// about to change.
  ///
  /// The split view controller calls this method when its display mode is
  /// about to change. Because changing the display mode usually means hiding
  /// or showing one of the child view controllers, you can implement this
  /// method and use it to add or remove the controls for showing the primary
  /// view controller.
  func splitViewController(_ splitViewController: SplitViewController, 
                           willChangeTo displayMode: SplitViewController.DisplayMode)

  /// Asks the delegate to provide the display mode to apply when a split view
  /// controller action occurs.
  ///
  /// This delegate method only applies to classic split view interfaces. For
  /// more information, see Split View Styles.
  ///
  /// The split view controller calls this method to determine which display
  /// mode to apply to itself in response to user-initiated actions. The split
  /// view controller has a built-in gesture recognizer that changes the current
  /// display mode. It also provides a bar button item from its
  /// `displayModeButtonItem` property that changes the display mode. The
  /// gesture recognizer is enabled using the `presentsWithGesture` property of
  /// the split view controller. Applications must incorporate the bar button
  /// item into their interface.
  ///
  /// Implement this method if you want to specify which display mode to apply
  /// to the split view controller in response to the user actions. The split
  /// view controller calls this method to obtain an updated value for the
  /// gesture and bar button item. If you do not implement this method or if
  /// your method returns `SplitViewController.DisplayMode.automatic`, the split
  /// view controller applies its own heuristics to determine which mode to
  /// apply when the next action is triggered. You cannot specify different
  /// display modes for the gesture and bar button item.
  func targetDisplayModeForAction(in splitViewController: SplitViewController)
      -> SplitViewController.DisplayMode

  // MARK - Collapsing the Interface

  /// Asks the delegate to provide the column to display after the split view
  /// interface collapses.
  ///
  /// This delegate method only applies to column-style split view interfaces.
  /// For more information, see Split View Styles.
  ///
  /// When the split view controller transitions from a horizontally regular to
  /// a horizontally compact size class, it calls this method and asks you for
  /// the column to display when that transition is complete. Use this method
  /// to customize the view controller you’re collapsing to. For example, you
  /// might use this opportunity to configure the interface in the view
  /// controller associated with the `SplitViewController.Column.compact` column
  /// before returning that column.
  func splitViewController(_ splitViewController: SplitViewController, 
                           topColumnForCollapsingToProposedTopColumn proposedTopColumn: SplitViewController.Column)
      -> SplitViewController.Column

  /// Tells the delegate that the specified column is about to be hidden.
  ///
  /// This delegate method only applies to column-style split view interfaces.
  /// For more information, see Split View Styles.
  ///
  /// The split view controller calls this method when one of its columns is
  /// about to be hidden, for example with `hide(_:)`. Use this method to
  /// perform any customization associated with hiding the column. You can use
  /// the split view controller's transitionCoordinator to coordinate any of
  /// your animations alongside the transition animation.
  func splitViewController(_ splitViewController: SplitViewController, 
                           willHide column: SplitViewController.Column)

  /// Tells the delegate that the split view controller interface has collapsed.
  ///
  /// This delegate method only applies to column-style split view interfaces.
  /// For more information, see Split View Styles.
  ///
  /// The split view controller calls this method after its interface has
  /// collapsed, meaning that `isCollapsed` is `true`. Use this method to
  /// perform any customization associated with the collapsed interface.
  func splitViewControllerDidCollapse(_ splitViewController: SplitViewController)

  // MARK - Expanding the Interface

  /// Asks the delegate to provide the display mode to use after the split view
  /// interface expands.
  ///
  /// This delegate method only applies to column-style split view interfaces.
  /// For more information, see Split View Styles.
  ///
  /// When the split view controller transitions from a horizontally compact to
  /// a horizontally regular size class, it calls this method and asks you for
  /// the display mode to use when that transition is complete. Use this method
  /// to customize the display mode you’re expanding to. For example, you might
  /// use this opportunity to adjust column widths before returning the display
  /// mode to use.
  func splitViewController(_ splitViewController: SplitViewController, 
                           displayModeForExpandingToProposedDisplayMode proposedDisplayMode: SplitViewController.DisplayMode)
      -> SplitViewController.DisplayMode

  /// Tells the delegate that the specified column is about to be shown.
  ///
  /// This delegate method only applies to column-style split view interfaces.
  /// For more information, see Split View Styles.
  ///
  /// The split view controller calls this method when one of its columns is
  /// about to be shown, for example with `show(_:)`. Use this method to perform
  /// any customization associated with showing the column. You can use the
  /// split view controller's `transitionCoordinator` to coordinate any of your
  /// animations alongside the transition animation.
  func splitViewController(_ splitViewController: SplitViewController, 
                           willShow column: SplitViewController.Column)

  /// Tells the delegate that the split view controller interface has expanded.
  ///
  /// This delegate method only applies to column-style split view interfaces.
  /// For more information, see Split View Styles.
  ///
  /// The split view controller calls this method after its interface has
  /// expanded, meaning that `isCollapsed` is `false`. Use this method to
  /// perform any customization associated with the expanded interface. 
  func splitViewControllerDidExpand(_ splitViewController: SplitViewController)

  // MARK - Handling the Presentation Gesture

  /// Tells the delegate that the interactive presentation gesture is about to begin.
  ///
  /// This delegate method only applies to column-style split view interfaces.
  /// For more information, see Split View Styles.
  ///
  /// The split view controller calls this method when the interactive
  /// presentation gesture is about to begin. Use this method for performance
  /// optimizations related to drawing the column content or other work related
  /// to handling the interactive gesture.
  func splitViewControllerInteractivePresentationGestureWillBegin(_ splitViewController: SplitViewController)

  /// Tells the delegate when the interactive presentation gesture ends.
  ///
  /// This delegate method only applies to column-style split view interfaces.
  /// For more information, see Split View Styles.
  ///
  /// The split view controller calls this method when the interactive
  /// presentation gesture ends. Use this method for performance optimizations
  /// related to drawing the column content or other work related to handling
  /// the interactive gesture.
  func splitViewControllerInteractivePresentationGestureDidEnd(_ splitViewController: SplitViewController)

  // MARK - Collapsing and Expanding Classic Split Views

  /// Asks the delegate to provide the single view controller to display after
  /// the split view interface collapses.
  ///
  /// This delegate method only applies to classic split view interfaces. For
  /// more information, see Split View Styles.
  ///
  /// When the split view controller transitions from a horizontally regular to
  /// a horizontally compact size class, it calls this method and asks you for
  /// the view controller to display when that transition is complete. The view
  /// controller you return becomes the new primary view controller of the split
  /// view interface.
  ///
  /// Use this method to specify which view controller you want to display in a
  /// compact environment. By default, a collapsing split view controller
  /// displays its current primary view controller, but you can return a
  /// different view controller if you want to. For example, you might return
  /// the secondary view controller if that view controller contains the content
  /// you want to display. You might also return a completely different view
  /// controller that is better suited for displaying content in a compact
  /// environment.
  ///
  /// If you implement this method, you should also implement the
  /// `primaryViewController(forExpanding:)` method to handle the expansion of
  /// your interface from a horizontally compact to a horizontally regular
  /// environment. If you do not implement this method, or if your
  /// implementation returns nil, the split view controller chooses its primary
  /// view controller as the one to display.
  func primaryViewController(forCollapsing splitViewController: SplitViewController)
      -> ViewController?

  /// Asks the delegate to adjust the primary view controller and to incorporate
  /// the secondary view controller into the collapsed interface.
  ///
  /// This delegate method only applies to classic split view interfaces. For
  /// more information, see Split View Styles.
  ///
  /// This method is your opportunity to perform any necessary tasks related to
  /// the transition to a collapsed interface. After this method returns, the
  /// split view controller removes the secondary view controller from its
  /// `viewControllers` array, leaving the primary view controller as its only
  /// child. In your implementation of this method, you might prepare the
  /// primary view controller for display in a compact environment, or you might
  /// attempt to incorporate the secondary view controller's content into the
  /// newly collapsed interface.
  ///
  /// Returning `false` tells the split view controller to use its default
  /// behavior to try to incorporate the secondary view controller into the
  /// collapsed interface. When you return `false`, the split view controller
  /// calls the `collapseSecondaryViewController(_:for:)` method of the primary
  /// view controller, giving it a chance to do something with the secondary
  /// view controller's content. Most view controllers do nothing by default,
  /// but the `NavigationController` class responds by pushing the secondary
  /// view controller onto its navigation stack.
  ///
  /// Returning `true` from this method tells the split view controller not to
  /// apply any default behavior. You might return `true` in cases where you do
  /// not want the secondary view controller's content incorporated into the
  /// resulting interface.
  func splitViewController(_ splitViewController: SplitViewController,
                           collapseSecondary secondaryViewController: ViewController,
                           onto primaryViewController: ViewController) -> Bool

  /// Asks the delegate to provide the view controller to display in the primary
  /// position when the split view interface expands.
  ///
  /// This delegate method only applies to classic split view interfaces. For
  /// more information, see Split View Styles.
  ///
  /// When the split view controller transitions from a horizontally compact to
  /// a horizontally regular size class, it calls this method and asks you for
  /// the view controller to display in the primary position when that
  /// transition is complete. The view controller you return becomes the primary
  /// view controller of the split view interface. If you do not implement this
  /// method, or if your implementation returns `nil`, the split view controller
  /// chooses its current primary view controller as the one to use.
  ///
  /// If you specified a specific view controller in your
  /// `primaryViewController(forCollapsing:)` method, use this method to restore
  /// the original primary view controller for your split view interface. You
  /// can also implement the `splitViewController(_:separateSecondaryFrom:)`
  /// method to disentangle your view controllers from one another as needed.
  func primaryViewController(forExpanding splitViewController: SplitViewController)
      -> ViewController?

  /// Asks the delegate to provide the new secondary view controller for the
  /// split view interface.
  ///
  /// This delegate method only applies to classic split view interfaces. For
  /// more information, see Split View Styles.
  ///
  /// Use this method to designate the secondary view controller for your split
  /// view interface and to perform any additional cleanup that might be needed.
  /// After this method returns, the split view controller installs the newly
  /// designated primary and secondary view controllers in its `viewControllers`
  /// array.
  ///
  /// When an interface collapses, some view controllers merge the contents of
  /// the primary and secondary view controllers. This method is your
  /// opportunity to undo those changes and return your split view interface to
  /// its original state.
  ///
  /// When you return nil from this method, the split view controller calls the
  /// primary view controller's `separateSecondaryViewController(for:)` method,
  /// giving it a chance to designate an appropriate secondary view controller.
  /// Most view controllers do nothing by default but the `NavigationController`
  /// class responds by popping and returning the view controller from the top
  /// of its navigation stack.
  func splitViewController(_ splitViewController: SplitViewController, 
                           separateSecondaryFrom primaryViewController: ViewController)
      -> ViewController?

  // MARK - Overrding the Presentation Behavior

  /// Asks the delegate if it will do the work of displaying a view controller
  /// in the primary position of the split view interface.
  ///
  /// This delegate method only applies to classic split view interfaces. For
  /// more information, see Split View Styles.
  ///
  /// When its `show(_:sender:)` method is called, the split view controller
  /// calls this method to see if your delegate will handle the presentation of
  /// the specified view controller. If you implement this method and your
  /// implementation returns `true`, you are responsible for presenting the
  /// specified view controller in the primary position of the split view
  /// interface. The split view controller does nothing more to try to show
  /// the view controller.
  ///
  /// If you don't implement this method or if your implementation returns
  /// `false`, the split view controller presents the view controller.
  func splitViewController(_ splitViewController: SplitViewController, 
                           show vc: ViewController, sender: Any?) -> Bool

  /// Asks the delegate if it will do the work of displaying a view controller
  /// in the secondary position of the split view interface.
  ///
  /// This delegate method only applies to classic split view interfaces. For
  /// more information, see Split View Styles.
  ///
  /// When its `showDetailViewController(_:sender:)` method is called, the split
  /// view controller calls this method to see if your delegate will handle the
  /// presentation of the specified view controller. If you implement this
  /// method and ultimately return `true`, your implementation is responsible
  /// for presenting the specified view controller in the secondary position of
  /// the split view interface.
  ///
  /// If you don't implement this method or if your implementation returns
  /// `false`, the split view controller presents the view controller.
  func splitViewController(_ splitViewController: SplitViewController, 
                           showDetail vc: ViewController, sender: Any?) -> Bool
}

extension SplitViewControllerDelegate {
  public func splitViewControllerPreferredInterfaceOrientationForPresentation(_ splitViewController: SplitViewController)
      -> InterfaceOrientation {
    .portrait
  }

  public func splitViewControllerSupportedInterfaceOrientations(_ splitViewController: SplitViewController)
      -> InterfaceOrientationMask {
    .all
  }
}

extension SplitViewControllerDelegate {
  public func splitViewController(_ splitViewController: SplitViewController, 
                                  willChangeTo displayMode: SplitViewController.DisplayMode) {
  }

  public func targetDisplayModeForAction(in splitViewController: SplitViewController)
      -> SplitViewController.DisplayMode {
    .automatic
  }
}

extension SplitViewControllerDelegate {
  public func splitViewController(_ splitViewController: SplitViewController, 
                                  topColumnForCollapsingToProposedTopColumn proposedTopColumn: SplitViewController.Column)
      -> SplitViewController.Column {
    proposedTopColumn
  }

  public func splitViewController(_ splitViewController: SplitViewController, 
                                  willHide column: SplitViewController.Column) {
  }


  public func splitViewControllerDidCollapse(_ splitViewController: SplitViewController) {
  }
}

extension SplitViewControllerDelegate {
  public func splitViewController(_ splitViewController: SplitViewController, 
                                  displayModeForExpandingToProposedDisplayMode proposedDisplayMode: SplitViewController.DisplayMode)
      -> SplitViewController.DisplayMode {
    proposedDisplayMode
  }

  public func splitViewController(_ splitViewController: SplitViewController, 
                                  willShow column: SplitViewController.Column) {
  }

  public func splitViewControllerDidExpand(_ splitViewController: SplitViewController) {
  }
}

extension SplitViewControllerDelegate {
  public func splitViewControllerInteractivePresentationGestureWillBegin(_ splitViewController: SplitViewController) {
  }

  public func splitViewControllerInteractivePresentationGestureDidEnd(_ splitViewController: SplitViewController) {
  }
}

extension SplitViewControllerDelegate {
  public func primaryViewController(forCollapsing splitViewController: SplitViewController)
      -> ViewController? {
    return nil
  }

  public func splitViewController(_ splitViewController: SplitViewController,
                                  collapseSecondary secondaryViewController: ViewController,
                                  onto primaryViewController: ViewController)
      -> Bool {
    false
  }

  public func primaryViewController(forExpanding splitViewController: SplitViewController)
      -> ViewController? {
    nil
  }

  public func splitViewController(_ splitViewController: SplitViewController, 
                                  separateSecondaryFrom primaryViewController: ViewController)
      -> ViewController? {
    return nil
  }
}

extension SplitViewControllerDelegate {
  public func splitViewController(_ splitViewController: SplitViewController, 
                                  show vc: ViewController, sender: Any?)
      -> Bool {
    false
  }

  public func splitViewController(_ splitViewController: SplitViewController, 
                                  showDetail vc: ViewController, sender: Any?)
      -> Bool {
    false
  }
}
