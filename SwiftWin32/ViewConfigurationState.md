---
layout: default
title: ViewConfigurationState
parent: SwiftWin32
---
# ViewConfigurationState

A structure that encapsulates a view's state.

``` swift
public struct ViewConfigurationState: ConfigurationState 
```

## Inheritance

[`ConfigurationState`](https://compnerd.github.io/swift-win32/SwiftWin32/ConfigurationState), `CustomDebugStringConvertible`, `CustomReflectable`, `CustomStringConvertible`, `Hashable`

## Initializers

### `init(traitCollection:)`

``` swift
public init(traitCollection: TraitCollection) 
```

## Properties

### `traitCollection`

The traits that describe the current layout environment of the view, such
as the user interface style and layout direction.

``` swift
public var traitCollection: TraitCollection
```

### `isSelected`

A boolean value that indicates whether the view is in a selected state.

``` swift
public var isSelected: Bool
```

### `isHighlighted`

A boolean value that indicates whether the view is in a highlighted state.

``` swift
public var isHighlighted: Bool
```

### `isFocused`

A boolean value that indicates whether the view is in a focused state.

``` swift
public var isFocused: Bool
```

### `isDisabled`

A boolean value that indicates whether the view is in a disabled state.

``` swift
public var isDisabled: Bool
```

### `description`

``` swift
public var description: String 
```

### `debugDescription`

``` swift
public var debugDescription: String 
```

### `customMirror`

``` swift
public var customMirror: Mirror 
```

## Methods

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: ViewConfigurationState,
                        _ rhs: ViewConfigurationState) -> Bool 
```
