---
layout: default
title: UserInterfaceLevel
parent: SwiftWin32
---
# UserInterfaceLevel

Constants that indicate the visual level for content in the window.

``` swift
public enum UserInterfaceLevel: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `unspecified`

An unspecified interface level.

``` swift
case unspecified = -1
```

Choose this option when you want to follow the inherited level.

### `base`

The level for your window's main content.

``` swift
case base
```

### `elevated`

The level for content visually above your window's main content.

``` swift
case elevated
```
