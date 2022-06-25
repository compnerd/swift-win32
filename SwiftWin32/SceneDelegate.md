---
layout: default
title: SceneDelegate
parent: SwiftWin32
---
# SceneDelegate

``` swift
public protocol SceneDelegate: _TriviallyConstructible 
```

## Inheritance

[`_TriviallyConstructible`](https://compnerd.github.io/swift-win32/SwiftWin32/_TriviallyConstructible)

## Default Implementations

### `scene(_:willConnectTo:options:)`

``` swift
public func scene(_ scene: Scene, willConnectTo: SceneSession,
                    options: Scene.ConnectionOptions) 
```

### `sceneDidDisconnect(_:)`

``` swift
public func sceneDidDisconnect(_ scene: Scene) 
```

### `sceneWillEnterForeground(_:)`

``` swift
public func sceneWillEnterForeground(_ scene: Scene) 
```

### `sceneDidBecomeActive(_:)`

``` swift
public func sceneDidBecomeActive(_ scene: Scene) 
```

### `sceneWillResignActive(_:)`

``` swift
public func sceneWillResignActive(_ scene: Scene) 
```

### `sceneDidEnterBackground(_:)`

``` swift
public func sceneDidEnterBackground(_ scene: Scene) 
```

## Requirements

### scene(\_:​willConnectTo:​options:​)

Informs the delegate about the addition of a scene to the application.

``` swift
func scene(_ scene: Scene, willConnectTo: SceneSession,
             options: Scene.ConnectionOptions)
```

### sceneDidDisconnect(\_:​)

Informs the delegate that a scene was removed from the application.

``` swift
func sceneDidDisconnect(_ scene: Scene)
```

### sceneWillEnterForeground(\_:​)

Informs the delegate that the scene is about to begin running in the
foreground and become visible to the user.

``` swift
func sceneWillEnterForeground(_ scene: Scene)
```

### sceneDidBecomeActive(\_:​)

Informs the delegate that the scene became active and is now responding to
user events.

``` swift
func sceneDidBecomeActive(_ scene: Scene)
```

### sceneWillResignActive(\_:​)

Informs the delegate that the scene is about to resign the active state
and stop responding to user events.

``` swift
func sceneWillResignActive(_ scene: Scene)
```

### sceneDidEnterBackground(\_:​)

Informs the delegate that the scene is running in the background and is no
longer onscreen.

``` swift
func sceneDidEnterBackground(_ scene: Scene)
```
