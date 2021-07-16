---
layout: default
title: WindowSceneDelegate
parent: SwiftWin32
---
# WindowSceneDelegate

Additional methods that you can use to manage application specific tasks
occurring in a scene.

``` swift
public protocol WindowSceneDelegate: SceneDelegate 
```

## Inheritance

[`SceneDelegate`](https://compnerd.github.io/swift-win32/SwiftWin32/SceneDelegate)

## Default Implementations

### `window`

``` swift
public var window: Window? 
```

### `windowScene(_:didUpdate:interfaceOrientation:traitCollection:)`

``` swift
public func windowScene(_ windowScene: WindowScene,
                          didUpdate previousCoordinateSpace: CoordinateSpace,
                          interfaceOrientation previousInterfaceOrientation: InterfaceOrientation,
                          traitCollection previousTraitCollection: TraitCollection) 
```

## Requirements

### window

The main window associated with the scene.

``` swift
var window: Window? 
```

### windowScene(\_:​didUpdate:​interfaceOrientation:​traitCollection:​)

Notifies you when the size, orientation, or traits of a scene change.

``` swift
func windowScene(_ windowScene: WindowScene,
                   didUpdate previousCoordinateSpace: CoordinateSpace,
                   interfaceOrientation previousInterfaceOrientation: InterfaceOrientation,
                   traitCollection previousTraitCollection: TraitCollection)
```
