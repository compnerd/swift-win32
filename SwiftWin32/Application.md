---
layout: default
title: Application
parent: SwiftWin32
---
# Application

The centralised point of control and coordination for running applications.

``` swift
open class Application: Responder 
```

## Inheritance

[`Responder`](https://compnerd.github.io/swift-win32/SwiftWin32/Responder)

## Initializers

### `init()`

``` swift
override public required init() 
```

## Properties

### `shared`

Returns the singleton application instance.

``` swift
public static var shared: Application 
```

### `delegate`

The delegate of the application object.

``` swift
public var delegate: ApplicationDelegate?
```

### `state`

The applications current state or that of its most active scene.

``` swift
public internal(set) var state: Application.State
```

### `supportsMultipleScenes`

A boolean indicating whether the application may display multiple scenes.

``` swift
public var supportsMultipleScenes: Bool 
```

### `connectedScenes`

The application's currently connected scenes.

``` swift
public internal(set) var connectedScenes: Set<Scene> = []
```

### `openSessions`

The sessions whose scenes are either currently active or archived by the
system.

``` swift
public internal(set) var openSessions: Set<SceneSession> = []
```

### `windows`

The application’s visible and hidden windows.

``` swift
public internal(set) var windows: [Window]
```

### `keyWindow`

The application's key window.

``` swift
public internal(set) var keyWindow: Window?
```

### `next`

``` swift
override public var next: Responder? 
```
