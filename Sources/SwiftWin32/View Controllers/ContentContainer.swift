// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A set of methods for adapting the contents of your view controllers to size
/// and trait changes.
public protocol ContentContainer {
  // MARK - Responding to Environment Changes

  /// Notifies the container that the size of its view is about to change.
  func willTransition(to: Size,
                      with coodinator: ViewControllerTransitionCoordinator)

  /// Notifies the container that its trait collection changed.
  func willTransition(to: TraitCollection,
                      with coordinator: ViewControllerTransitionCoordinator)

  // MARK - Responding to Changes in Child View Controllers

  /// The preferred size for the container's content.
  var preferredContentSize: Size { get }

  /// Returns the size of the specified child view controller's content.
  func size(forChildContentContainer container: ContentContainer,
            withParentContainerSize parentSize: Size) -> Size

  /// Notifies an interested controller that the preferred content size of one of
  /// its children changed.
  func preferredContentSizeDidChange(forChildContentContainer container: ContentContainer)

  /// Notifies the container that a child view controller was resized using auto
  /// layout.
  func systemLayoutFittingSizeDidChange(forChildContentContainer container: ContentContainer)
}
