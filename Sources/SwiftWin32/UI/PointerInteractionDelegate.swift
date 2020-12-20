/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// An interface for handling pointer movements within the interaction's view.
public protocol PointerInteractionDelegate: AnyObject {
  // MARK - Defining Pointer Styles for Regions

  /// Asks the delegate for a region as the pointer moves within the
  /// interaction's view.
  func pointerInteraction(_ interaction: PointerInteraction,
                          regionFor request: PointerRegionRequest,
                          defaultRegion: PointerRegion) -> PointerRegion?

  /// Asks the delegate for a pointer style after an interaction receives a new
  /// region.
  func pointerInteraction(_ interaction: PointerInteraction,
                          styleFor region: PointerRegion) -> PointerStyle?

  // MARK - Handling Animations for Pointer Regions

  /// Informs the delegate when the pointer enters a given region.
  func pointerInteraction(_ interaction: PointerInteraction,
                          willEnter region: PointerRegion,
                          animator: PointerInteractionAnimating)

  /// Informs the delegate when the pointer exits a given region.
  func pointerInteraction(_ interaction: PointerInteraction,
                          willExit region: PointerRegion,
                          animator: PointerInteractionAnimating)
}

extension PointerInteractionDelegate {
  public func pointerInteraction(_ interaction: PointerInteraction,
                                 regionFor request: PointerRegionRequest,
                                 defaultRegion: PointerRegion)
      -> PointerRegion? {
    return nil
  }

  public func pointerInteraction(_ interaction: PointerInteraction,
                                 styleFor region: PointerRegion)
      -> PointerStyle? {
    return nil
  }
}

extension PointerInteractionDelegate {
  public func pointerInteraction(_ interaction: PointerInteraction,
                                 willEnter region: PointerRegion,
                                 animator: PointerInteractionAnimating) {
  }

  public func pointerInteraction(_ interaction: PointerInteraction,
                                 willExit region: PointerRegion,
                                 animator: PointerInteractionAnimating) {
  }
}
