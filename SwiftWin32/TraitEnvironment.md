---
layout: default
title: TraitEnvironment
parent: SwiftWin32
---
# TraitEnvironment

A set of methods that makes the interface environment available to your
application.

``` swift
public protocol TraitEnvironment 
```

## Requirements

### traitCollection

The traits, such as the size class and scale factor, that describe the
current environment of the object.

``` swift
var traitCollection: TraitCollection 
```

### traitCollectionDidChange(\_:​)

Called when the interface environment changes.

``` swift
func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?)
```
