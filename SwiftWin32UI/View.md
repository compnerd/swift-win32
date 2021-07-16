---
layout: default
title: View
parent: SwiftWin32UI
---
# View

A type that represents part of your app’s user interface and provides
modifiers that you use to configure views.

``` swift
public protocol View 
```

## Default Implementations

### `body`

``` swift
public var body: Never 
```

## Requirements

### Body

The type of view representing the body of this view.

``` swift
associatedtype Body: View
```

### body

The content and behavior of the view.

``` swift
@ViewBuilder
  var body: Self.Body 
```
