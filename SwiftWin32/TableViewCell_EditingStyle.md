---
layout: default
title: TableViewCell.EditingStyle
parent: SwiftWin32
---
# TableViewCell.EditingStyle

The editing control used by a cell.

``` swift
public enum EditingStyle: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `none`

The cell has no editing control. This is the default value.

``` swift
case none
```

### `delete`

The cell has the delete editing control; this control is a red circle
enclosing a minus sign.

``` swift
case delete
```

### `insert`

The cell has the insert editing control; this control is a green circle
enclosing a plus sign.

``` swift
case insert
```
