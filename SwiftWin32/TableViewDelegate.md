---
layout: default
title: TableViewDelegate
parent: SwiftWin32
---
# TableViewDelegate

Methods for managing selections, configuring section headers and footers,
deleting and reordering cells, and performing other actions in a table view.

``` swift
public protocol TableViewDelegate: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `tableView(_:willDisplay:forRowAt:)`

``` swift
public func tableView(_ tableView: TableView, willDisplay cell: TableViewCell,
                        forRowAt indexPath: IndexPath) 
```

### `tableView(_:indentationLevelForRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        indentationLevelForRowAt indexPath: IndexPath) -> Int 
```

### `tableView(_:shouldSpringLoadRowAt:with:)`

``` swift
public func tableView(_ tableView: TableView,
                        shouldSpringLoadRowAt indexPath: IndexPath,
                        with context: SpringLoadedInteractionContext) -> Bool 
```

### `tableView(_:willSelectRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        willSelectRowAt indexPath: IndexPath) -> IndexPath? 
```

### `tableView(_:didSelectRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        didSelectRowAt indexPath: IndexPath) 
```

### `tableView(_:willDeselectRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        willDeselectRowAt indexPath: IndexPath) -> IndexPath? 
```

### `tableView(_:didDeselectRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        didDeselectRowAt indexPath: IndexPath) 
```

### `tableView(_:shouldBeginMultipleSelectionInteractionAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath)
      -> Bool 
```

### `tableView(_:didBeginMultipleSelectionInteractionAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        didBeginMultipleSelectionInteractionAt indexPath: IndexPath) 
```

### `tableViewDidEndMultipleSelectionInteraction(_:)`

``` swift
public func tableViewDidEndMultipleSelectionInteraction(_ tableView: TableView) 
```

### `tableView(_:viewForHeaderInSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        viewForHeaderInSection section: Int) -> View? 
```

### `tableView(_:viewForFooterInSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        viewForFooterInSection section: Int) -> View? 
```

### `tableView(_:willDisplayHeaderView:forSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        willDisplayHeaderView view: View,
                        forSection section: Int) 
```

### `tableView(_:willDisplayFooterView:forSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        willDisplayFooterView view: View,
                        forSection section: Int) 
```

### `tableView(_:heightForRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        heightForRowAt indexPath: IndexPath) -> Double 
```

### `tableView(_:heightForHeaderInSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        heightForHeaderInSection section: Int) -> Double 
```

### `tableView(_:heightForFooterInSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        heightForFooterInSection section: Int) -> Double 
```

### `automaticDimension`

``` swift
public static var automaticDimension: Double 
```

### `tableView(_:estimatedHeightForRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        estimatedHeightForRowAt indexPath: IndexPath) -> Double 
```

### `tableView(_:estimatedHeightForHeaderInSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        estimatedHeightForHeaderInSection section: Int)
      -> Double 
```

### `tableView(_:estimatedHeightForFooterInSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        estimatedHeightForFooterInSection section: Int)
      -> Double 
```

### `tableView(_:accessoryButtonTappedForRowWith:)`

``` swift
public func tableView(_ tableView: TableView,
                       accessoryButtonTappedForRowWith indexPath: IndexPath) 
```

### `tableView(_:contextMenuConfigurationForRowAt:point:)`

``` swift
public func tableView(_ tableView: TableView,
                        contextMenuConfigurationForRowAt indexPath: IndexPath,
                        point: Point) -> ContextMenuConfiguration? 
```

### `tableView(_:previewForDismissingContextMenuWithConfiguration:)`

``` swift
public func tableView(_ tableView: TableView,
                        previewForDismissingContextMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview? 
```

### `tableView(_:previewForHighlightingContextMenuWithConfiguration:)`

``` swift
public func tableView(_ tableView: TableView,
                        previewForHighlightingContextMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview? 
```

### `tableView(_:willDisplayContextMenu:animator:)`

``` swift
public func tableView(_ tableView: TableView,
                        willDisplayContextMenu configuration: ContextMenuConfiguration,
                        animator: ContextMenuInteractionAnimating?) 
```

### `tableView(_:willEndContextMenuInteraction:animator:)`

``` swift
public func tableView(_ tableView: TableView,
                        willEndContextMenuInteraction configuration: ContextMenuConfiguration,
                        animator: ContextMenuInteractionAnimating?) 
```

### `tableView(_:willPerformPreviewActionForMenuWith:animator:)`

``` swift
public func tableView(_ tableView: TableView,
                        willPerformPreviewActionForMenuWith configuration: ContextMenuConfiguration,
                        animator: ContextMenuInteractionCommitAnimating) 
```

### `tableView(_:leadingSwipeActionsConfigurationForRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> SwipeActionsConfiguration? 
```

### `tableView(_:trailingSwipeActionsConfigurationForRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> SwipeActionsConfiguration? 
```

### `tableView(_:shouldHighlightRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        shouldHighlightRowAt indexPath: IndexPath) -> Bool 
```

### `tableView(_:didHighlightRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        didHighlightRowAt indexPath: IndexPath) 
```

### `tableView(_:didUnhighlightRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        didUnhighlightRowAt indexPath: IndexPath) 
```

### `tableView(_:willBeginEditingRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        willBeginEditingRowAt indexPath: IndexPath) 
```

### `tableView(_:didEndEditingRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        didEndEditingRowAt indexPath: IndexPath?) 
```

### `tableView(_:editingStyleForRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        editingStyleForRowAt indexPath: IndexPath)
      -> TableViewCell.EditingStyle 
```

### `tableView(_:titleForDeleteConfirmationButtonForRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath)
      -> String? 
```

### `tableView(_:shouldIndentWhileEditingRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        shouldIndentWhileEditingRowAt indexPath: IndexPath)
      -> Bool 
```

### `tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:)`

``` swift
public func tableView(_ tableView: TableView,
                        targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                        toProposedIndexPath proposedDestinationIndexPath: IndexPath)
      -> IndexPath 
```

### `tableView(_:didEndDisplaying:forRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        didEndDisplaying cell: TableViewCell,
                        forRowAt indexPath: IndexPath) 
```

### `tableView(_:didEndDisplayingHeaderView:forSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        didEndDisplayingHeaderView view: View,
                        forSection section: Int) 
```

### `tableView(_:didEndDisplayingFooterView:forSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        didEndDisplayingFooterView view: View,
                        forSection section: Int) 
```

### `tableView(_:canFocusRowAt:)`

``` swift
public func tableView(_ tableView: TableView,
                        canFocusRowAt indexPath: IndexPath) -> Bool 
```

### `tableView(_:shouldUpdateFocusIn:)`

``` swift
public func tableView(_ tableView: TableView,
                        shouldUpdateFocusIn context: TableViewFocusUpdateContext)
      -> Bool 
```

### `tableView(_:didUpdateFocusIn:with:)`

``` swift
public func tableView(_ tableView: TableView,
                        didUpdateFocusIn context: TableViewFocusUpdateContext,
                        with coordinator: FocusAnimationCoordinator) 
```

### `indexPathForPreferredFocusedView(in:)`

``` swift
public func indexPathForPreferredFocusedView(in tableView: TableView)
      -> IndexPath? 
```

## Requirements

### tableView(\_:​willDisplay:​forRowAt:​)

Informs the delegate the table view is about to draw a cell for a
particular row.

``` swift
func tableView(_ tableView: TableView, willDisplay cell: TableViewCell,
                 forRowAt indexPath: IndexPath)
```

### tableView(\_:​indentationLevelForRowAt:​)

Asks the delegate to return the level of indentation for a row in a given
section.

``` swift
func tableView(_ tableView: TableView,
                 indentationLevelForRowAt indexPath: IndexPath) -> Int
```

### tableView(\_:​shouldSpringLoadRowAt:​with:​)

Called to let you fine tune the spring-loading behavior of the rows in a
table.

``` swift
func tableView(_ tableView: TableView,
                 shouldSpringLoadRowAt indexPath: IndexPath,
                 with context: SpringLoadedInteractionContext) -> Bool
```

### tableView(\_:​willSelectRowAt:​)

Informs the delegate a row is about to be selected.

``` swift
func tableView(_ tableView: TableView, willSelectRowAt indexPath: IndexPath)
      -> IndexPath?
```

### tableView(\_:​didSelectRowAt:​)

Informs the delegate a row is selected.

``` swift
func tableView(_ tableView: TableView, didSelectRowAt indexPath: IndexPath)
```

### tableView(\_:​willDeselectRowAt:​)

Informs the delegate that a specified row is about to be deselected.

``` swift
func tableView(_ tableView: TableView, willDeselectRowAt indexPath: IndexPath)
      -> IndexPath?
```

### tableView(\_:​didDeselectRowAt:​)

Informs the delegate that the specified row is now deselected.

``` swift
func tableView(_ tableView: TableView, didDeselectRowAt indexPath: IndexPath)
```

### tableView(\_:​shouldBeginMultipleSelectionInteractionAt:​)

Asks the delegate whether the user can use a two-finger pan gesture to
select multiple items in a table view.

``` swift
func tableView(_ tableView: TableView,
                 shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath)
      -> Bool
```

### tableView(\_:​didBeginMultipleSelectionInteractionAt:​)

Informs the delegate when the user starts using a two-finger pan gesture
to select multiple rows in a table view.

``` swift
func tableView(_ tableView: TableView,
                 didBeginMultipleSelectionInteractionAt indexPath: IndexPath)
```

### tableViewDidEndMultipleSelectionInteraction(\_:​)

Informs the delegate when the user stops using a two-finger pan gesture to
select multiple rows in a table view.

``` swift
func tableViewDidEndMultipleSelectionInteraction(_ tableView: TableView)
```

### tableView(\_:​viewForHeaderInSection:​)

Asks the delegate for a view object to display in the header of the
specified section of the table view.

``` swift
func tableView(_ tableView: TableView, viewForHeaderInSection section: Int)
      -> View?
```

### tableView(\_:​viewForFooterInSection:​)

Asks the delegate for a view object to display in the footer of the
specified section of the table view.

``` swift
func tableView(_ tableView: TableView, viewForFooterInSection section: Int)
      -> View?
```

### tableView(\_:​willDisplayHeaderView:​forSection:​)

Informs the delegate that the table is about to display the header view
for the specified section.

``` swift
func tableView(_ tableView: TableView, willDisplayHeaderView view: View,
                 forSection section: Int)
```

### tableView(\_:​willDisplayFooterView:​forSection:​)

Informs the delegate that the table is about to display the footer view
for the specified section.

``` swift
func tableView(_ tableView: TableView, willDisplayFooterView view: View,
                 forSection section: Int)
```

### tableView(\_:​heightForRowAt:​)

Asks the delegate for the height to use for a row in a specified location.

``` swift
func tableView(_ tableView: TableView, heightForRowAt indexPath: IndexPath)
      -> Double
```

### tableView(\_:​heightForHeaderInSection:​)

Asks the delegate for the height to use for the header of a particular
section.

``` swift
func tableView(_ tableView: TableView, heightForHeaderInSection section: Int)
      -> Double
```

### tableView(\_:​heightForFooterInSection:​)

Asks the delegate for the height to use for the footer of a particular
section.

``` swift
func tableView(_ tableView: TableView, heightForFooterInSection section: Int)
      -> Double
```

### automaticDimension

``` swift
static var automaticDimension: Double 
```

### tableView(\_:​estimatedHeightForRowAt:​)

Asks the delegate for the estimated height of a row in a specified
location.

``` swift
func tableView(_ tableView: TableView,
                 estimatedHeightForRowAt indexPath: IndexPath) -> Double
```

### tableView(\_:​estimatedHeightForHeaderInSection:​)

Asks the delegate for the estimated height of the header of a particular
section.

``` swift
func tableView(_ tableView: TableView,
                 estimatedHeightForHeaderInSection section: Int) -> Double
```

### tableView(\_:​estimatedHeightForFooterInSection:​)

Asks the delegate for the estimated height of the footer of a particular
section.

``` swift
func tableView(_ tableView: TableView,
                 estimatedHeightForFooterInSection section: Int) -> Double
```

### tableView(\_:​accessoryButtonTappedForRowWith:​)

Informs the delegate that the user tapped the detail button for the
specified row.

``` swift
func tableView(_ tableView: TableView,
                 accessoryButtonTappedForRowWith indexPath: IndexPath)
```

### tableView(\_:​contextMenuConfigurationForRowAt:​point:​)

Returns a context menu configuration for the row at a point.

``` swift
func tableView(_ tableView: TableView,
                 contextMenuConfigurationForRowAt indexPath: IndexPath,
                 point: Point) -> ContextMenuConfiguration?
```

### tableView(\_:​previewForDismissingContextMenuWithConfiguration:​)

Returns the destination view when dismissing a context menu.

``` swift
func tableView(_ tableView: TableView,
                 previewForDismissingContextMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview?
```

### tableView(\_:​previewForHighlightingContextMenuWithConfiguration:​)

Returns a view to override the default preview the table view created.

``` swift
func tableView(_ tableView: TableView,
                 previewForHighlightingContextMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview?
```

### tableView(\_:​willDisplayContextMenu:​animator:​)

Informs the delegate when a context menu will appear.

``` swift
func tableView(_ tableView: TableView,
                 willDisplayContextMenu configuration: ContextMenuConfiguration,
                 animator: ContextMenuInteractionAnimating?)
```

### tableView(\_:​willEndContextMenuInteraction:​animator:​)

Informs the delegate when a context menu will disappear.

``` swift
func tableView(_ tableView: TableView,
                 willEndContextMenuInteraction configuration: ContextMenuConfiguration,
                 animator: ContextMenuInteractionAnimating?)
```

### tableView(\_:​willPerformPreviewActionForMenuWith:​animator:​)

Informs the delegate when a user triggers a commit by tapping the preview.

``` swift
func tableView(_ tableView: TableView,
                 willPerformPreviewActionForMenuWith configuration: ContextMenuConfiguration,
                 animator: ContextMenuInteractionCommitAnimating)
```

### tableView(\_:​leadingSwipeActionsConfigurationForRowAt:​)

Returns the swipe actions to display on the leading edge of the row.

``` swift
func tableView(_ tableView: TableView,
                 leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> SwipeActionsConfiguration?
```

### tableView(\_:​trailingSwipeActionsConfigurationForRowAt:​)

Returns the swipe actions to display on the trailing edge of the row.

``` swift
func tableView(_ tableView: TableView,
                 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> SwipeActionsConfiguration?
```

### tableView(\_:​shouldHighlightRowAt:​)

Asks the delegate if the specified row should be highlighted.

``` swift
func tableView(_ tableView: TableView,
                 shouldHighlightRowAt indexPath: IndexPath) -> Bool
```

### tableView(\_:​didHighlightRowAt:​)

Informs the delegate that the specified row was highlighted.

``` swift
func tableView(_ tableView: TableView, didHighlightRowAt indexPath: IndexPath)
```

### tableView(\_:​didUnhighlightRowAt:​)

Informs the delegate that the highlight was removed from the row at the
specified index path.

``` swift
func tableView(_ tableView: TableView,
                 didUnhighlightRowAt indexPath: IndexPath)
```

### tableView(\_:​willBeginEditingRowAt:​)

Informs the delegate that the table view is about to go into editing mode.

``` swift
func tableView(_ tableView: TableView,
                 willBeginEditingRowAt indexPath: IndexPath)
```

### tableView(\_:​didEndEditingRowAt:​)

Informs the delegate that the table view has left editing mode.

``` swift
func tableView(_ tableView: TableView,
                 didEndEditingRowAt indexPath: IndexPath?)
```

### tableView(\_:​editingStyleForRowAt:​)

Asks the delegate for the editing style of a row at a particular location
in a table view.

``` swift
func tableView(_ tableView: TableView,
                 editingStyleForRowAt indexPath: IndexPath)
      -> TableViewCell.EditingStyle
```

### tableView(\_:​titleForDeleteConfirmationButtonForRowAt:​)

Changes the default title of the delete-confirmation button.

``` swift
func tableView(_ tableView: TableView,
                 titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath)
      -> String?
```

### tableView(\_:​shouldIndentWhileEditingRowAt:​)

Asks the delegate whether the background of the specified row should be
indented while the table view is in editing mode.

``` swift
func tableView(_ tableView: TableView,
                 shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
```

### tableView(\_:​targetIndexPathForMoveFromRowAt:​toProposedIndexPath:​)

Asks the delegate to return a new index path to retarget a proposed move
of a row.

``` swift
func tableView(_ tableView: TableView,
                 targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                 toProposedIndexPath proposedDestinationIndexPath: IndexPath)
      -> IndexPath
```

### tableView(\_:​didEndDisplaying:​forRowAt:​)

Informs the delegate that the specified cell was removed from the table.

``` swift
func tableView(_ tableView: TableView, didEndDisplaying cell: TableViewCell,
                 forRowAt indexPath: IndexPath)
```

### tableView(\_:​didEndDisplayingHeaderView:​forSection:​)

Informs the delegate that the specified header view was removed from the
table.

``` swift
func tableView(_ tableView: TableView, didEndDisplayingHeaderView view: View,
                 forSection section: Int)
```

### tableView(\_:​didEndDisplayingFooterView:​forSection:​)

Informs the delegate that the specified footer view was removed from the
table.

``` swift
func tableView(_ tableView: TableView, didEndDisplayingFooterView view: View,
                 forSection section: Int)
```

### tableView(\_:​canFocusRowAt:​)

Asks the delegate whether the cell at the specified index path is itself
focusable.

``` swift
func tableView(_ tableView: TableView, canFocusRowAt indexPath: IndexPath)
      -> Bool
```

### tableView(\_:​shouldUpdateFocusIn:​)

Asks the delegate whether the focus update specified by the context is
allowed to occur.

``` swift
func tableView(_ tableView: TableView,
                 shouldUpdateFocusIn context: TableViewFocusUpdateContext)
      -> Bool
```

### tableView(\_:​didUpdateFocusIn:​with:​)

Informs the delegate that a focus update specified by the context has just
occurred.

``` swift
func tableView(_ tableView: TableView,
                 didUpdateFocusIn context: TableViewFocusUpdateContext,
                 with coordinator: FocusAnimationCoordinator)
```

### indexPathForPreferredFocusedView(in:​)

Asks the delegate for the table view’s index path for the preferred
focused view.

``` swift
func indexPathForPreferredFocusedView(in tableView: TableView) -> IndexPath?
```
