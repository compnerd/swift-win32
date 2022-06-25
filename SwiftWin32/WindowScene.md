---
layout: default
title: WindowScene
parent: SwiftWin32
---
# WindowScene

``` swift
public class WindowScene: Scene 
```

## Inheritance

[`Scene`](https://compnerd.github.io/swift-win32/SwiftWin32/Scene)

## Initializers

### `init(session:connectionOptions:)`

``` swift
public required init(session: SceneSession,
                       connectionOptions: Scene.ConnectionOptions) 
```

## Properties

### `windows`

Getting the Active Windows
The windows associated with the scene.

``` swift
public internal(set) var windows: [Window] = []
```

### `screen`

The screen that displays the content of the scene.

``` swift
public private(set) var screen: Screen
```

### `sizeRestrictions`

Getting the Interface Attributes
The minimum and maximum size of the application's windows.

``` swift
public private(set) var sizeRestrictions: SceneSizeRestrictions?
```
