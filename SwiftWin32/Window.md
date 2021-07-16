---
layout: default
title: Window
parent: SwiftWin32
---
# Window

The backdrop for your application’s user interface and the object that
dispatches events to your views.

``` swift
public class Window: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32/View)

## Initializers

### `init(frame:)`

``` swift
public init(frame: Rect) 
```

### `init(windowScene:)`

Creates a Window and associates it with the specified scene object.

``` swift
public init(windowScene: WindowScene) 
```

## Properties

### `rootViewController`

The root view controller for the window.

``` swift
public var rootViewController: ViewController? 
```

### `windowLevel`

The position of the window in the z-axis.

``` swift
public var windowLevel: Window.Level = .normal 
```

### `screen`

The screen on which the window is displayed.

``` swift
@available(*, deprecated, message: "use windowScene.scene")
  public var screen: Screen 
```

### `canResizeToFitContent`

A boolean value that indicates whether the window's constraint-based
content determines its size.

``` swift
public var canResizeToFitContent: Bool = false 
```

### `isKeyWindow`

A boolean value that indicates whether the window is the key window for
the application.

``` swift
public var isKeyWindow: Bool 
```

### `canBecomeKey`

A boolean value that indicates whether the window can become the key
window.

``` swift
public var canBecomeKey: Bool = true 
```

### `windowScene`

The scene containing the window.

``` swift
public weak var windowScene: WindowScene? 
```

### `didBecomeVisibleNotification`

Posted whn a `Window` object becomes visible.

``` swift
public class var didBecomeVisibleNotification: NSNotification.Name 
```

### `didBecomeHiddenNotification`

Posted when a `Window` object becomes hidden.

``` swift
public class var didBecomeHiddenNotification: NSNotification.Name 
```

### `didBecomeKeyNotification`

Posted whenever a `Window` object becomes the key window.

``` swift
public class var didBecomeKeyNotification: NSNotification.Name 
```

### `didResignKeyNotification`

Posted when a `Window` object resigns its status as main window.

``` swift
public class var didResignKeyNotification: NSNotification.Name 
```

### `next`

``` swift
override public var next: Responder? 
```

### `isMinimizable`

``` swift
public var isMinimizable: Bool 
```

## Methods

### `makeKeyAndVisible()`

Shows the window and makes it the key window.

``` swift
public func makeKeyAndVisible() 
```

### `makeKey()`

Makes the receiver the key window.

``` swift
public func makeKey() 
```

### `becomeKey()`

Called automatically to inform the window that it has become the key
window.

``` swift
public func becomeKey() 
```

### `resignKey()`

Called automatically to inform the window that it is no longer the key
window.

``` swift
public func resignKey() 
```
