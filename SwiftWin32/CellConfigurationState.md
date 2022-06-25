---
layout: default
title: CellConfigurationState
parent: SwiftWin32
---
# CellConfigurationState

A structure that encapsulates a cell's state.

``` swift
public struct CellConfigurationState: ConfigurationState 
```

## Inheritance

[`ConfigurationState`](https://compnerd.github.io/swift-win32/SwiftWin32/ConfigurationState)

## Initializers

### `init(traitCollection:)`

Creates a cell configuration state with the specified trait collection.

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

A boolean value that indicates whether the cell is in a selected state.

``` swift
public var isSelected: Bool = false
```

### `isHighlighted`

A boolean value that indicates whether the cell is in a highlighted state.

``` swift
public var isHighlighted: Bool = false
```

### `isFocused`

A boolean value that indicates whether the cell is in a focused state.

``` swift
public var isFocused: Bool = false
```

### `isDisabled`

A boolean value that indicates whether the cell is in a disabled state.

``` swift
public var isDisabled: Bool = false
```
