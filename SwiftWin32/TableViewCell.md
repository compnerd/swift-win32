---
layout: default
title: TableViewCell
parent: SwiftWin32
---
# TableViewCell

The visual representation of a single row in a table view.

``` swift
public class TableViewCell: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32/View)

## Initializers

### `init(style:reuseIdentifier:)`

Initializes a table cell with a style and a reuse identifier and returns it
to the caller.

``` swift
public init(style: TableViewCell.CellStyle, reuseIdentifier: String?) 
```

## Properties

### `reuseIdentifier`

A string used to identify a cell that is reusable.

``` swift
public let reuseIdentifier: String?
```

### `isEditing`

A boolean value that indicates whether the cell is in an editable state.

``` swift
public var isEditing: Bool = false
```

### `editingStyle`

The editing style of the cell.

``` swift
public private(set) var editingStyle: TableViewCell.EditingStyle = .none
```

### `showingDeleteConfirmation`

A boolean value that indicates whether the cell is currently showing the
delete-confirmation button.

``` swift
public private(set) var showingDeleteConfirmation: Bool = false
```

### `showsReorderControl`

A boolean value that determines whether the cell shows the reordering
control.

``` swift
public var showsReorderControl: Bool = false 
```

## Methods

### `sizeThatFits(_:)`

``` swift
public override func sizeThatFits(_ size: Size) -> Size 
```

### `prepareForReuse()`

Prepares a reusable cell for reuse by the table view's delegate.

``` swift
public func prepareForReuse() 
```

### `setEditing(_:animated:)`

Toggles the receiver into and out of editing mode.

``` swift
public func setEditing(_ editing: Bool, animated: Bool) 
```
