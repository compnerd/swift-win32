---
layout: default
title: AnyView
parent: SwiftWin32UI
---
# AnyView

A type-erased view.

``` swift
@frozen
public struct AnyView: View 
```

An `AnyView` allows changing the type of view used in a given view
hierarchy. Whenever the type of view used with an `AnyView` changes, the old
hierarchy is destroyed and a new hierarchy is created for the new type.

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32UI/View)

## Nested Type Aliases

### `Body`

``` swift
public typealias Body = Never
```

## Initializers

### `init(_:)`

Create an instance that type-erases `view`.

``` swift
public init<ViewType: View>(_ view: ViewType) 
```

### `init(erasing:)`

``` swift
@_alwaysEmitIntoClient
  public init<ViewType: View>(erasing view: ViewType) 
```
