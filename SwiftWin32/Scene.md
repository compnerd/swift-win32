---
layout: default
title: Scene
parent: SwiftWin32
---
# Scene

``` swift
public class Scene: Responder 
```

## Inheritance

[`Responder`](https://compnerd.github.io/swift-win32/SwiftWin32/Responder), `Hashable`

## Initializers

### `init(session:connectionOptions:)`

Creating a Scene Object
Creates a scene object using the specified session and connection
information.

``` swift
public required init(session: SceneSession,
                       connectionOptions: Scene.ConnectionOptions) 
```

## Properties

### `delegate`

Managing the Life Cycle of a Scene
The object you use to recieve life-cycle events associated with the scene.

``` swift
public var delegate: SceneDelegate?
```

### `session`

Getting the Scene's Session
The session associated with the scene.

``` swift
public let session: SceneSession
```

### `willConnectNotification`

A notification indicating that a scene was added to the application.

``` swift
public class var willConnectNotification: NSNotification.Name 
```

### `didDisconnectNotification`

A notification indicating that a scene was removed from the application.

``` swift
public class var didDisconnectNotification: NSNotification.Name 
```

### `willEnterForegroundNotification`

A notification indicating that a scene is about to begin running in the
foreground and become visible to the user.

``` swift
public class var willEnterForegroundNotification: NSNotification.Name 
```

### `didActivateNotification`

A notification indicating that the scene is now onscreen and reponding to
user events.

``` swift
public class var didActivateNotification: NSNotification.Name 
```

### `willDeactivateNotification`

A notification indicating that the scene is about to resign the active
state and stop responding to user events.

``` swift
public class var willDeactivateNotification: NSNotification.Name 
```

### `didEnterBackgroundNotification`

A notification indicating that the scene is running in the background and
is no longer onscreen.

``` swift
public class var didEnterBackgroundNotification: NSNotification.Name 
```

## Methods

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func == (lhs: Scene, rhs: Scene) -> Bool 
```
