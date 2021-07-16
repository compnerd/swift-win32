---
layout: default
title: TableViewHeaderFooterView
parent: SwiftWin32
---
# TableViewHeaderFooterView

A reusable view that you place at the top or bottom of a table section to
display additional information for that section.

``` swift
public class TableViewHeaderFooterView: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32/View)

## Initializers

### `init(reuseIdentifier:)`

Initializes a header/footer view with the specified reuse identifier.

``` swift
public init(reuseIdentifier identifier: String?) 
```

## Properties

### `reuseIdentifier`

A string used to identify a reusable header or footer.

``` swift
public private(set) var reuseIdentifier: String?
```

### `backgroundConfiguration`

The current background configuration of the view.

``` swift
public var backgroundConfiguration: BackgroundConfiguration? 
```

### `automaticallyUpdatesBackgroundConfiguration`

A boolean value that determines whether the view automatically updates its
background configuration when its state changes.

``` swift
public var automaticallyUpdatesBackgroundConfiguration: Bool = true
```

### `backgroundView`

The background view of the header or footer.

``` swift
public var backgroundView: View? 
```

### `contentConfiguration`

The current content configuration of the view.

``` swift
public var contentConfiguration: ContentConfiguration?
```

### `automaticallyUpdatesContentConfiguration`

A boolean value that determines whether the view automatically updates its
content configuration when its state changes.

``` swift
public var automaticallyUpdatesContentConfiguration: Bool = true
```

### `contentView`

The content view of the header or footer.

``` swift
public private(set) var contentView: View
```

### `configurationState`

The current configuration state of the view.

``` swift
public private(set) var configurationState: ViewConfigurationState
```

## Methods

### `prepareForReuse()`

Prepares a reusable header or footer view for reuse by the table.

``` swift
public func prepareForReuse() 
```

### `defaultContentConfiguration()`

Retrieves a default list content configuration for the view's style.

``` swift
public func defaultContentConfiguration() -> ListContentConfiguration 
```

### `setNeedsUpdateConfiguration()`

Informs the view to update its configuration for its current state.

``` swift
public func setNeedsUpdateConfiguration() 
```

### `updateConfiguration(using:)`

Updates the view's configuration using the current state.

``` swift
public func updateConfiguration(using state: ViewConfigurationState) 
```
