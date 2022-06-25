---
layout: default
title: LayoutPriority
parent: SwiftWin32
---
# LayoutPriority

The layout priority is used to indicate to the constraint-based layout
system which constraints are more important, allowing the system to make
appropriate tradeoffs when satisfying the constraints of the system as a
whole.

``` swift
public struct LayoutPriority: Equatable, Hashable, RawRepresentable 
```

## Inheritance

`Equatable`, `Hashable`, `RawRepresentable`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = Float
```

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: RawValue) 
```

### `init(_:)`

``` swift
public init(_ rawValue: RawValue) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `required`

A required constraint.

``` swift
public static var required: LayoutPriority 
```

### `defaultHigh`

The priority level with which a button resists compressing its content.

``` swift
public static var defaultHigh: LayoutPriority 
```

### `defaultLow`

The priority level with which a button hugs its contents horizontally.

``` swift
public static var defaultLow: LayoutPriority 
```

### `fittingSizeLevel`

The priority level with which the view wants to conform to the target size
in that computation.

``` swift
public static var fittingSizeLevel: LayoutPriority 
```

### `dragThatCanResizeScene`

The priority with which a drag may end up resizing the window's scene.

``` swift
public static var dragThatCanResizeScene: LayoutPriority 
```

### `dragThatCannotResizeScene`

The priority with which the a split view divider is dragged.

``` swift
public static var dragThatCannotResizeScene: LayoutPriority 
```

### `sceneSizeStayPut`

The priority with which the window's scene prefers to stay the same size.

``` swift
public static var sceneSizeStayPut: LayoutPriority 
```
