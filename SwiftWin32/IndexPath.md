---
layout: default
title: IndexPath
parent: SwiftWin32
---
# Extensions on IndexPath

## Initializers

### `init(row:section:)`

Initializes an index path with the indexes of a specific row and section
in a table view.

``` swift
public init(row: Int, section: Int) 
```

### `init(item:section:)`

Initializes an index path with the index of a specific item and section in
a collection view.

``` swift
public init(item: Int, section: Int) 
```

## Properties

### `section`

An index number identifying a section in a table view or collection view.

``` swift
public var section: Int 
```

### `row`

An index number identifying a row in a section of a table view.

``` swift
public var row: Int 
```

### `item`

An index number identifying an item in a section of a collection view.

``` swift
public var item: Int 
```
