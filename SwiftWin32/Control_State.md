---
layout: default
title: Control.State
parent: SwiftWin32
---
# Control.State

The state of the control, specified as a bit mask value.

``` swift
struct State: OptionSet 
```

## Inheritance

`OptionSet`

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: Int) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: Int
```

### `normal`

The normal, or default state of a control—that is, enabled but neither
selected nor highlighted.

``` swift
static var normal: Control.State 
```

### `highlighted`

Highlighted state of a control.

``` swift
static var highlighted: Control.State 
```

### `disabled`

Disabled state of a control.

``` swift
static var disabled: Control.State 
```

### `selected`

Selected state of a control.

``` swift
static var selected: Control.State 
```

### `focused`

Focused state of a control.

``` swift
static var focused: Control.State 
```

### `application`

Additional control-state flags available for application use.

``` swift
static var application: Control.State 
```

### `reserved`

Control-state flags reserved for internal framework use.

``` swift
static var reserved: Control.State 
```
