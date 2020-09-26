/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public protocol ContentContainer {
  /// Responding to Environment Changes
  func willTransition(to: Size,
                      with coodinator: ViewControllerTransitionCoordinator)
  func willTransition(to: TraitCollection,
                      with coordinator: ViewControllerTransitionCoordinator)

  /// Responding to Changes in Child View Controllers
  var preferredContentSize: Size { get }

  func size(forChildContentContainer container: ContentContainer,
            withParentContainerSize parentSize: Size) -> Size
  func preferredContentSizeDidChange(forChildContentContainer container: ContentContainer)
  func systemLayoutFittingSizeDidChange(forChildContentContainer container: ContentContainer)
}
