---
layout: default
title: PickerView
parent: SwiftWin32
---
# PickerView

A view that shows one or more sets of values.

``` swift
public class PickerView: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32/View)

## Initializers

### `init(frame:)`

``` swift
public init(frame: Rect = .zero) 
```

## Properties

### `dataSource`

The data source for the picker view.

``` swift
public weak var dataSource: PickerViewDataSource?
```

### `delegate`

The delegate for the picker view.

``` swift
public weak var delegate: PickerViewDelegate?
```

### `numberOfComponents`

Gets the number of components for the picker view.

``` swift
public var numberOfComponents: Int 
```

## Methods

### `numberOfRows(inComponent:)`

Returns the number of rows for a component.

``` swift
public func numberOfRows(inComponent component: Int) -> Int 
```

### `rowSize(forComponent:)`

Returns the size of a row for a component.

``` swift
public func rowSize(forComponent component: Int) -> Size 
```

### `reloadAllComponents()`

Reloads all components of the picker view.

``` swift
public func reloadAllComponents() 
```

### `reloadComponent(_:)`

Reloads a particular component of the picker view.

``` swift
public func reloadComponent(_ component: Int) 
```

### `selectRow(_:inComponent:animated:)`

Selects a row ina  specified component of the picker view.

``` swift
public func selectRow(_ row: Int, inComponent component: Int, animated: Bool) 
```

### `selectedRow(inComponent:)`

Returns the index of the selected row in a given component.

``` swift
public func selectedRow(inComponent component: Int) -> Int 
```

### `view(forRow:forComponent:reusing:)`

Returns the view used by the picker view for a given row and component.

``` swift
public func view(forRow row: Int, forComponent component: Int,
                   reusing view: View?) -> View? 
```
