---
layout: default
title: WindowGroup
parent: SwiftWin32UI
---
# WindowGroup

A scene that presents a group of identically structured windows.

``` swift
public struct WindowGroup<Content: View>: Scene 
```

## Inheritance

[`Scene`](https://compnerd.github.io/swift-win32/SwiftWin32UI/Scene)

## Initializers

### `init(content:)`

Creates a window group.

``` swift
public init(@ViewBuilder content: () -> Content) 
```

## Properties

### `body`

``` swift
public var body: some Scene 
```
