// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import struct Foundation.IndexPath

#if swift(>=5.7)
import CoreGraphics
#endif

/// Methods for managing selections, configuring section headers and footers,
/// deleting and reordering cells, and performing other actions in a table view.
public protocol TableViewDelegate: AnyObject {
  // MARK - Configuring Rows for the Table View

  /// Informs the delegate the table view is about to draw a cell for a
  /// particular row.
  func tableView(_ tableView: TableView, willDisplay cell: TableViewCell,
                 forRowAt indexPath: IndexPath)

  /// Asks the delegate to return the level of indentation for a row in a given
  /// section.
  func tableView(_ tableView: TableView,
                 indentationLevelForRowAt indexPath: IndexPath) -> Int

  /// Called to let you fine tune the spring-loading behavior of the rows in a
  /// table.
  func tableView(_ tableView: TableView,
                 shouldSpringLoadRowAt indexPath: IndexPath,
                 with context: SpringLoadedInteractionContext) -> Bool

  // MARK - Responding to Row Selections

  /// Informs the delegate a row is about to be selected.
  func tableView(_ tableView: TableView, willSelectRowAt indexPath: IndexPath)
      -> IndexPath?

  /// Informs the delegate a row is selected.
  func tableView(_ tableView: TableView, didSelectRowAt indexPath: IndexPath)

  /// Informs the delegate that a specified row is about to be deselected.
  func tableView(_ tableView: TableView, willDeselectRowAt indexPath: IndexPath)
      -> IndexPath?

  /// Informs the delegate that the specified row is now deselected.
  func tableView(_ tableView: TableView, didDeselectRowAt indexPath: IndexPath)

  /// Asks the delegate whether the user can use a two-finger pan gesture to
  /// select multiple items in a table view.
  func tableView(_ tableView: TableView,
                 shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath)
      -> Bool

  /// Informs the delegate when the user starts using a two-finger pan gesture
  /// to select multiple rows in a table view.
  func tableView(_ tableView: TableView,
                 didBeginMultipleSelectionInteractionAt indexPath: IndexPath)

  /// Informs the delegate when the user stops using a two-finger pan gesture to
  /// select multiple rows in a table view.
  func tableViewDidEndMultipleSelectionInteraction(_ tableView: TableView)

  // MARK - Providing Custom Header and Footer Views

  /// Asks the delegate for a view object to display in the header of the
  /// specified section of the table view.
  func tableView(_ tableView: TableView, viewForHeaderInSection section: Int)
      -> View?

  /// Asks the delegate for a view object to display in the footer of the
  /// specified section of the table view.
  func tableView(_ tableView: TableView, viewForFooterInSection section: Int)
      -> View?

  /// Informs the delegate that the table is about to display the header view
  /// for the specified section.
  func tableView(_ tableView: TableView, willDisplayHeaderView view: View,
                 forSection section: Int)

  /// Informs the delegate that the table is about to display the footer view
  /// for the specified section.
  func tableView(_ tableView: TableView, willDisplayFooterView view: View,
                 forSection section: Int)

  // MARK - Providing Header, Footer, and Row Heights

  /// Asks the delegate for the height to use for a row in a specified location.
  func tableView(_ tableView: TableView, heightForRowAt indexPath: IndexPath)
      -> Double

  /// Asks the delegate for the height to use for the header of a particular
  /// section.
  func tableView(_ tableView: TableView, heightForHeaderInSection section: Int)
      -> Double

  /// Asks the delegate for the height to use for the footer of a particular
  /// section.
  func tableView(_ tableView: TableView, heightForFooterInSection section: Int)
      -> Double

  static var automaticDimension: Double { get }

  // MARK - Estimating Heights for the Table's Content

  /// Asks the delegate for the estimated height of a row in a specified
  /// location.
  func tableView(_ tableView: TableView,
                 estimatedHeightForRowAt indexPath: IndexPath) -> Double

  /// Asks the delegate for the estimated height of the header of a particular
  /// section.
  func tableView(_ tableView: TableView,
                 estimatedHeightForHeaderInSection section: Int) -> Double

  /// Asks the delegate for the estimated height of the footer of a particular
  /// section.
  func tableView(_ tableView: TableView,
                 estimatedHeightForFooterInSection section: Int) -> Double

  // MARK - Managing Accessory Views

  /// Informs the delegate that the user tapped the detail button for the
  /// specified row.
  func tableView(_ tableView: TableView,
                 accessoryButtonTappedForRowWith indexPath: IndexPath)

  // MARK - Managing Context Menus

  /// Returns a context menu configuration for the row at a point.
  func tableView(_ tableView: TableView,
                 contextMenuConfigurationForRowAt indexPath: IndexPath,
                 point: Point) -> ContextMenuConfiguration?

  /// Returns the destination view when dismissing a context menu.
  func tableView(_ tableView: TableView,
                 previewForDismissingContextMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview?

  /// Returns a view to override the default preview the table view created.
  func tableView(_ tableView: TableView,
                 previewForHighlightingContextMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview?

  /// Informs the delegate when a context menu will appear.
  func tableView(_ tableView: TableView,
                 willDisplayContextMenu configuration: ContextMenuConfiguration,
                 animator: ContextMenuInteractionAnimating?)

  /// Informs the delegate when a context menu will disappear.
  func tableView(_ tableView: TableView,
                 willEndContextMenuInteraction configuration: ContextMenuConfiguration,
                 animator: ContextMenuInteractionAnimating?)

  /// Informs the delegate when a user triggers a commit by tapping the preview.
  func tableView(_ tableView: TableView,
                 willPerformPreviewActionForMenuWith configuration: ContextMenuConfiguration,
                 animator: ContextMenuInteractionCommitAnimating)

  // MARK - Responding to Row Actions

  /// Returns the swipe actions to display on the leading edge of the row.
  func tableView(_ tableView: TableView,
                 leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> SwipeActionsConfiguration?

  /// Returns the swipe actions to display on the trailing edge of the row.
  func tableView(_ tableView: TableView,
                 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> SwipeActionsConfiguration?

  // MARK - Managing Table View Highlights

  /// Asks the delegate if the specified row should be highlighted.
  func tableView(_ tableView: TableView,
                 shouldHighlightRowAt indexPath: IndexPath) -> Bool

  /// Informs the delegate that the specified row was highlighted.
  func tableView(_ tableView: TableView, didHighlightRowAt indexPath: IndexPath)

  /// Informs the delegate that the highlight was removed from the row at the
  /// specified index path.
  func tableView(_ tableView: TableView,
                 didUnhighlightRowAt indexPath: IndexPath)

  // MARK - Editing Table Rows

  /// Informs the delegate that the table view is about to go into editing mode.
  func tableView(_ tableView: TableView,
                 willBeginEditingRowAt indexPath: IndexPath)

  /// Informs the delegate that the table view has left editing mode.
  func tableView(_ tableView: TableView,
                 didEndEditingRowAt indexPath: IndexPath?)

  /// Asks the delegate for the editing style of a row at a particular location
  /// in a table view.
  func tableView(_ tableView: TableView,
                 editingStyleForRowAt indexPath: IndexPath)
      -> TableViewCell.EditingStyle

  /// Changes the default title of the delete-confirmation button.
  func tableView(_ tableView: TableView,
                 titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath)
      -> String?

  /// Asks the delegate whether the background of the specified row should be
  /// indented while the table view is in editing mode.
  func tableView(_ tableView: TableView,
                 shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool

  // MARK - Reordering Table Rows

  /// Asks the delegate to return a new index path to retarget a proposed move
  /// of a row.
  func tableView(_ tableView: TableView,
                 targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                 toProposedIndexPath proposedDestinationIndexPath: IndexPath)
      -> IndexPath

  // MARK - Tracking Removal of Views

  /// Informs the delegate that the specified cell was removed from the table.
  func tableView(_ tableView: TableView, didEndDisplaying cell: TableViewCell,
                 forRowAt indexPath: IndexPath)

  /// Informs the delegate that the specified header view was removed from the
  /// table.
  func tableView(_ tableView: TableView, didEndDisplayingHeaderView view: View,
                 forSection section: Int)

  /// Informs the delegate that the specified footer view was removed from the
  /// table.
  func tableView(_ tableView: TableView, didEndDisplayingFooterView view: View,
                 forSection section: Int)

  // MARK - Managing Table View Focus

  /// Asks the delegate whether the cell at the specified index path is itself
  /// focusable.
  func tableView(_ tableView: TableView, canFocusRowAt indexPath: IndexPath)
      -> Bool

  /// Asks the delegate whether the focus update specified by the context is
  /// allowed to occur.
  func tableView(_ tableView: TableView,
                 shouldUpdateFocusIn context: TableViewFocusUpdateContext)
      -> Bool

  /// Informs the delegate that a focus update specified by the context has just
  /// occurred.
  func tableView(_ tableView: TableView,
                 didUpdateFocusIn context: TableViewFocusUpdateContext,
                 with coordinator: FocusAnimationCoordinator)

  /// Asks the delegate for the table view’s index path for the preferred
  /// focused view.
  func indexPathForPreferredFocusedView(in tableView: TableView) -> IndexPath?
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView, willDisplay cell: TableViewCell,
                        forRowAt indexPath: IndexPath) {
  }

  public func tableView(_ tableView: TableView,
                        indentationLevelForRowAt indexPath: IndexPath) -> Int {
    0
  }

  public func tableView(_ tableView: TableView,
                        shouldSpringLoadRowAt indexPath: IndexPath,
                        with context: SpringLoadedInteractionContext) -> Bool {
      return true
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return indexPath
  }

  public func tableView(_ tableView: TableView,
                        didSelectRowAt indexPath: IndexPath) {
  }

  public func tableView(_ tableView: TableView,
                        willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
    return indexPath
  }

  public func tableView(_ tableView: TableView,
                        didDeselectRowAt indexPath: IndexPath) {
  }

  public func tableView(_ tableView: TableView,
                        shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath)
      -> Bool {
    return false
  }

  public func tableView(_ tableView: TableView,
                        didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
  }

  public func tableViewDidEndMultipleSelectionInteraction(_ tableView: TableView) {
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        viewForHeaderInSection section: Int) -> View? {
    return nil
  }

  public func tableView(_ tableView: TableView,
                        viewForFooterInSection section: Int) -> View? {
    return nil
  }

  public func tableView(_ tableView: TableView,
                        willDisplayHeaderView view: View,
                        forSection section: Int) {
  }

  public func tableView(_ tableView: TableView,
                        willDisplayFooterView view: View,
                        forSection section: Int) {
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        heightForRowAt indexPath: IndexPath) -> Double {
    return Self.automaticDimension
  }

  public func tableView(_ tableView: TableView,
                        heightForHeaderInSection section: Int) -> Double {
    return Self.automaticDimension
  }

  public func tableView(_ tableView: TableView,
                        heightForFooterInSection section: Int) -> Double {
    return Self.automaticDimension
  }

  public static var automaticDimension: Double {
    return .greatestFiniteMagnitude
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        estimatedHeightForRowAt indexPath: IndexPath) -> Double {
    return Self.automaticDimension
  }

  public func tableView(_ tableView: TableView,
                        estimatedHeightForHeaderInSection section: Int)
      -> Double {
    return Self.automaticDimension
  }

  public func tableView(_ tableView: TableView,
                        estimatedHeightForFooterInSection section: Int)
      -> Double {
    return Self.automaticDimension
  }
}

extension TableViewDelegate {
 public func tableView(_ tableView: TableView,
                       accessoryButtonTappedForRowWith indexPath: IndexPath) {
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        contextMenuConfigurationForRowAt indexPath: IndexPath,
                        point: Point) -> ContextMenuConfiguration? {
    return nil
  }

  public func tableView(_ tableView: TableView,
                        previewForDismissingContextMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview? {
    return nil
  }

  public func tableView(_ tableView: TableView,
                        previewForHighlightingContextMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview? {
    return nil
  }

  public func tableView(_ tableView: TableView,
                        willDisplayContextMenu configuration: ContextMenuConfiguration,
                        animator: ContextMenuInteractionAnimating?) {
  }

  public func tableView(_ tableView: TableView,
                        willEndContextMenuInteraction configuration: ContextMenuConfiguration,
                        animator: ContextMenuInteractionAnimating?) {
  }

  public func tableView(_ tableView: TableView,
                        willPerformPreviewActionForMenuWith configuration: ContextMenuConfiguration,
                        animator: ContextMenuInteractionCommitAnimating) {
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> SwipeActionsConfiguration? {
    return nil
  }

  public func tableView(_ tableView: TableView,
                        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> SwipeActionsConfiguration? {
    return nil
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  public func tableView(_ tableView: TableView,
                        didHighlightRowAt indexPath: IndexPath) {
  }

  public func tableView(_ tableView: TableView,
                        didUnhighlightRowAt indexPath: IndexPath) {
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        willBeginEditingRowAt indexPath: IndexPath) {
  }

  public func tableView(_ tableView: TableView,
                        didEndEditingRowAt indexPath: IndexPath?) {
  }

  public func tableView(_ tableView: TableView,
                        editingStyleForRowAt indexPath: IndexPath)
      -> TableViewCell.EditingStyle {
    return (tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath).isEditing ?? false)
        ? .delete
        : .none
  }

  public func tableView(_ tableView: TableView,
                        titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath)
      -> String? {
    // FIXME(compnerd) localize the string
    return "Delete"
  }

  public func tableView(_ tableView: TableView,
                        shouldIndentWhileEditingRowAt indexPath: IndexPath)
      -> Bool {
    return true
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                        toProposedIndexPath proposedDestinationIndexPath: IndexPath)
      -> IndexPath {
    return proposedDestinationIndexPath
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        didEndDisplaying cell: TableViewCell,
                        forRowAt indexPath: IndexPath) {
  }

  public func tableView(_ tableView: TableView,
                        didEndDisplayingHeaderView view: View,
                        forSection section: Int) {
  }

  public func tableView(_ tableView: TableView,
                        didEndDisplayingFooterView view: View,
                        forSection section: Int) {
  }
}

extension TableViewDelegate {
  public func tableView(_ tableView: TableView,
                        canFocusRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  public func tableView(_ tableView: TableView,
                        shouldUpdateFocusIn context: TableViewFocusUpdateContext)
      -> Bool {
    return true
  }

  public func tableView(_ tableView: TableView,
                        didUpdateFocusIn context: TableViewFocusUpdateContext,
                        with coordinator: FocusAnimationCoordinator) {
  }

  public func indexPathForPreferredFocusedView(in tableView: TableView)
      -> IndexPath? {
    // XXX(compnerd) is this correct?
    return nil
  }
}
