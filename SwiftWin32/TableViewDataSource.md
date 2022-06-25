---
layout: default
title: TableViewDataSource
parent: SwiftWin32
---
# TableViewDataSource

``` swift
public protocol TableViewDataSource: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `numberOfSections(in:)`

``` swift
public func numberOfSections(in tableView: TableView) -> Int 
```

### `tableView(_:titleForHeaderInSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        titleForHeaderInSection section: Int) -> String? 
```

### `tableView(_:titleForFooterInSection:)`

``` swift
public func tableView(_ tableView: TableView,
                        titleForFooterInSection section: Int) -> String? 
```

## Requirements

### tableView(\_:​numberOfRowsInSection:​)

Informs the data source to return the number of rows in a given section of
a table view.

``` swift
func tableView(_ tableView: TableView, numberOfRowsInSection section: Int)
      -> Int
```

### numberOfSections(in:​)

Asks the data source to return the number of sections in the table view.

``` swift
func numberOfSections(in tableView: TableView) -> Int
```

### tableView(\_:​cellForRowAt:​)

Asks the data source for a cell to insert in a particular location of the
table view.

``` swift
func tableView(_ tableView: TableView, cellForRowAt indexPath: IndexPath)
      -> TableViewCell
```

### tableView(\_:​titleForHeaderInSection:​)

Asks the data source for the title of the header of the specified section
of the table view.

``` swift
func tableView(_ tableView: TableView, titleForHeaderInSection section: Int)
      -> String?
```

### tableView(\_:​titleForFooterInSection:​)

Asks the data source for the title of the footer of the specified section
of the table view.

``` swift
func tableView(_ tableView: TableView, titleForFooterInSection section: Int)
      -> String?
```
