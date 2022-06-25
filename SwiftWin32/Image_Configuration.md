---
layout: default
title: Image.Configuration
parent: SwiftWin32
---
# Image.Configuration

A configuration object that contains the traits that the system uses when
selecting the current image variant.

``` swift
public class Configuration 
```

## Properties

### `traitCollection`

The traits associated with the image configuration.

``` swift
public private(set) var traitCollection: TraitCollection?
```

## Methods

### `applying(_:)`

Returns a configuration object that applies the specified configuration
values on top of the current object's values.

``` swift
public func applying(_ otherConfiguration: Image.Configuration?) -> Self 
```

### `withTraitCollection(_:)`

Returns a new configuration object that merges the current traits with
the traits from the specified trait collection.

``` swift
public func withTraitCollection(_ traitCollection: TraitCollection?) -> Self 
```
