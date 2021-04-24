// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The methods for providing the set of actions to perform on your content,
/// and for customizing the preview of that content.
public protocol ContextMenuInteractionDelegate: AnyObject {
  // MARK - Providing the Preview Configuration Data

  /// Returns the configuration data to use when previewing the content.
  func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              configurationForMenuAtLocation location: Point)
      -> ContextMenuConfiguration?

  // MARK - Customizing the Preview Animations

  /// Returns the source view to use when animating the appearance of the
  /// preview interface.
  func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              previewForHighlightingMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview?

  /// Returns the destination view to use when animating the appearance of the
  /// preview interface.
  func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              previewForDismissingMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview?

  // MARK - Responding to the Menu's Appearance

  /// Informs the delegate when a preview action begins.
  func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              willPerformPreviewActionForMenuWith configuration: ContextMenuConfiguration,
                              animator: ContextMenuInteractionCommitAnimating)

  // MARK - Handling Animations

  /// Informs the delegate when a menu display begins.
  func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              willDisplayMenuFor configuration: ContextMenuConfiguration,
                              animator: ContextMenuInteractionAnimating?)

  /// Informs the delegate when a menu display ends.
  func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              willEndFor configuration: ContextMenuConfiguration,
                              animator: ContextMenuInteractionAnimating?)
}

extension ContextMenuInteractionDelegate {
  public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     previewForHighlightingMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview? {
    // TODO(compnerd) what should the default be?
    return nil
  }

  public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     previewForDismissingMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview? {
    // TODO(compnerd) what should the default be?
    return nil
  }
}

extension ContextMenuInteractionDelegate {
  public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     willPerformPreviewActionForMenuWith configuration: ContextMenuConfiguration,
                                     animator: ContextMenuInteractionCommitAnimating) {
  }
}

extension ContextMenuInteractionDelegate {
  public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     willDisplayMenuFor configuration: ContextMenuConfiguration,
                                     animator: ContextMenuInteractionAnimating?) {
  }

  public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     willEndFor configuration: ContextMenuConfiguration,
                                     animator: ContextMenuInteractionAnimating?) {
  }
}
