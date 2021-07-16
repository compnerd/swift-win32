---
layout: default
title: EquatableView
parent: SwiftWin32UI
---
# EquatableView

A view type that compares itself against its previous value and prevents its
child updating if its new value is the same as its old value.

``` swift
@frozen
public struct EquatableView<Content: View & Equatable>: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32UI/View)

## Nested Type Aliases

### `Body`

``` swift
public typealias Body = Never
```

## Initializers

### `init(content:)`

``` swift
@inlinable
  public init(content: Content) 
```

## Properties

### `content`

``` swift
public var content: Content
```
