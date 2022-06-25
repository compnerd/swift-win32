---
layout: default
title: ContentContainer
parent: SwiftWin32
---
# ContentContainer

A set of methods for adapting the contents of your view controllers to size
and trait changes.

``` swift
public protocol ContentContainer 
```

## Requirements

### willTransition(to:​with:​)

Notifies the container that the size of its view is about to change.

``` swift
func willTransition(to: Size,
                      with coodinator: ViewControllerTransitionCoordinator)
```

### willTransition(to:​with:​)

Notifies the container that its trait collection changed.

``` swift
func willTransition(to: TraitCollection,
                      with coordinator: ViewControllerTransitionCoordinator)
```

### preferredContentSize

The preferred size for the container's content.

``` swift
var preferredContentSize: Size 
```

### size(forChildContentContainer:​withParentContainerSize:​)

Returns the size of the specified child view controller's content.

``` swift
func size(forChildContentContainer container: ContentContainer,
            withParentContainerSize parentSize: Size) -> Size
```

### preferredContentSizeDidChange(forChildContentContainer:​)

Notifies an interested controller that the preferred content size of one of
its children changed.

``` swift
func preferredContentSizeDidChange(forChildContentContainer container: ContentContainer)
```

### systemLayoutFittingSizeDidChange(forChildContentContainer:​)

Notifies the container that a child view controller was resized using auto
layout.

``` swift
func systemLayoutFittingSizeDidChange(forChildContentContainer container: ContentContainer)
```
