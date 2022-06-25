---
layout: default
title: BarMetrics
parent: SwiftWin32
---
# BarMetrics

Constants to specify metrics to use for appearance.

``` swift
public enum BarMetrics: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `` `default` ``

Specifies default metrics for the device.

``` swift
case `default`
```

### `compact`

Specifies metrics when using the phone idiom.

``` swift
case compact
```

### `defaultPrompt`

Specifies default metrics for the device for bars with the
prompt property, such as `NavigationBar` and `SearchBar`.

``` swift
case defaultPrompt
```

### `compactPrompt`

Specifies metrics for bars with the prompt property when using
the phone idiom, such as `NavigationBar` and `SearchBar`.

``` swift
case compactPrompt
```

## Properties

### `landscapePhone`

Specifies metrics for landscape orientation using the phone idiom.

``` swift
@available(*, unavailable)
  public static var landscapePhone: BarMetrics 
```

### `landscapePhonePrompt`

Specifies metrics for landscape orientation using the phone idiom
for bars with the prompt property, such as `NavigationBar` and
`SearchBar`.

``` swift
@available(*, unavailable)
  public static var landscapePhonePrompt: BarMetrics 
```
