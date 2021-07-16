---
layout: default
title: Control
parent: SwiftWin32
---
# Control

The base class for controls, which are visual elements that convey a
specific action or intention in response to user interactions.

``` swift
public class Control: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32/View)

## Properties

### `allControlEvents`

Returns the events for which the control has associated actions.

``` swift
public private(set) var allControlEvents: Control.Event 
```

## Methods

### `addTarget(_:action:for:)`

Associates a target object and action method with the control.

``` swift
public func addTarget<Target: AnyObject>(_ target: Target,
                                           action: @escaping (Target) -> () -> Void,
                                           for controlEvents: Control.Event) 
```

### `addTarget(_:action:for:)`

Associates a target object and action method with the control.

``` swift
public func addTarget<Source: Control, Target: AnyObject>(_ target: Target,
                                                            action: @escaping (Target) -> (_: Source) -> Void,
                                                            for controlEvents: Control.Event) 
```

### `addTarget(_:action:for:)`

Associates a target object and action method with the control.

``` swift
public func addTarget<Source: Control, Target: AnyObject>(_ target: Target,
                                                            action: @escaping (Target) -> (_: Source, _: Control.Event) -> Void,
                                                            for controlEvents: Control.Event) 
```
