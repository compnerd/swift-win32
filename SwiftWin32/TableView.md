---
layout: default
title: TableView
parent: SwiftWin32
---
# TableView

A view that presents data using rows arranged in a single column.

``` swift
public class TableView: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32/View)

## Initializers

### `init(frame:style:)`

Initializes and returns a table view having the given frame and style.

``` swift
public init(frame: Rect, style: TableView.Style) 
```

## Properties

### `dataSource`

The object that acts as the data source of the table view.

``` swift
public weak var dataSource: TableViewDataSource? 
```

### `style`

The style of the table view.

``` swift
public let style: TableView.Style
```

### `allowsMultipleSelection`

A boolean value that determines whether users can select more than one row
outside of editing mode.

``` swift
public var allowsMultipleSelection: Bool 
```

## Methods

### `reloadData()`

Reloads the rows and sections of the table view.

``` swift
public func reloadData() 
```
