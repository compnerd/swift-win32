---
layout: default
title: ContextMenuConfiguration
parent: SwiftWin32
---
# ContextMenuConfiguration

Returns the configuration data to use when previewing the content.

``` swift
public class ContextMenuConfiguration 
```

## Nested Type Aliases

### `ContextMenuContentPreviewProvider`

Returns the custom view controller to use when previewing your content.

``` swift
public typealias ContextMenuContentPreviewProvider = () -> ViewController?
```

### `ContextMenuActionProvider`

Returns an action-based contextual menu, optionally incorporating the
system-suggested actions.

``` swift
public typealias ContextMenuActionProvider = ([MenuElement]) -> Menu?
```

## Initializers

### `init(identifier:previewProvider:actionProvider:)`

Creates a menu configuration object with the specified action and preview
providers.

``` swift
public convenience init(identifier: NSCopying?,
                          previewProvider: ContextMenuContentPreviewProvider?,
                          actionProvider: ContextMenuActionProvider? = nil) 
```

## Properties

### `identifier`

The unique identifier for this configuration object.

``` swift
public let identifier: NSCopying
```
