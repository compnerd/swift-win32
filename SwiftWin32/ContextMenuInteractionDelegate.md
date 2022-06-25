---
layout: default
title: ContextMenuInteractionDelegate
parent: SwiftWin32
---
# ContextMenuInteractionDelegate

The methods for providing the set of actions to perform on your content,
and for customizing the preview of that content.

``` swift
public protocol ContextMenuInteractionDelegate: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `contextMenuInteraction(_:previewForHighlightingMenuWithConfiguration:)`

``` swift
public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     previewForHighlightingMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview? 
```

### `contextMenuInteraction(_:previewForDismissingMenuWithConfiguration:)`

``` swift
public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     previewForDismissingMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview? 
```

### `contextMenuInteraction(_:willPerformPreviewActionForMenuWith:animator:)`

``` swift
public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     willPerformPreviewActionForMenuWith configuration: ContextMenuConfiguration,
                                     animator: ContextMenuInteractionCommitAnimating) 
```

### `contextMenuInteraction(_:willDisplayMenuFor:animator:)`

``` swift
public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     willDisplayMenuFor configuration: ContextMenuConfiguration,
                                     animator: ContextMenuInteractionAnimating?) 
```

### `contextMenuInteraction(_:willEndFor:animator:)`

``` swift
public func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                                     willEndFor configuration: ContextMenuConfiguration,
                                     animator: ContextMenuInteractionAnimating?) 
```

## Requirements

### contextMenuInteraction(\_:​configurationForMenuAtLocation:​)

Returns the configuration data to use when previewing the content.

``` swift
func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              configurationForMenuAtLocation location: Point)
      -> ContextMenuConfiguration?
```

### contextMenuInteraction(\_:​previewForHighlightingMenuWithConfiguration:​)

Returns the source view to use when animating the appearance of the
preview interface.

``` swift
func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              previewForHighlightingMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview?
```

### contextMenuInteraction(\_:​previewForDismissingMenuWithConfiguration:​)

Returns the destination view to use when animating the appearance of the
preview interface.

``` swift
func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              previewForDismissingMenuWithConfiguration configuration: ContextMenuConfiguration)
      -> TargetedPreview?
```

### contextMenuInteraction(\_:​willPerformPreviewActionForMenuWith:​animator:​)

Informs the delegate when a preview action begins.

``` swift
func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              willPerformPreviewActionForMenuWith configuration: ContextMenuConfiguration,
                              animator: ContextMenuInteractionCommitAnimating)
```

### contextMenuInteraction(\_:​willDisplayMenuFor:​animator:​)

Informs the delegate when a menu display begins.

``` swift
func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              willDisplayMenuFor configuration: ContextMenuConfiguration,
                              animator: ContextMenuInteractionAnimating?)
```

### contextMenuInteraction(\_:​willEndFor:​animator:​)

Informs the delegate when a menu display ends.

``` swift
func contextMenuInteraction(_ interaction: ContextMenuInteraction,
                              willEndFor configuration: ContextMenuConfiguration,
                              animator: ContextMenuInteractionAnimating?)
```
