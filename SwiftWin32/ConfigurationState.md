---
layout: default
title: ConfigurationState
parent: SwiftWin32
---
# ConfigurationState

The requirements for an object that encapsulate a view's state.

``` swift
public protocol ConfigurationState 
```

## Requirements

### traitCollection

The traits that describe the current layout environment of the view, such
as the user interface style and layout direction.

``` swift
var traitCollection: TraitCollection 
```

### subscript(key:​)

Accesses custom states by key.

``` swift
subscript(key: ConfigurationStateCustomKey) -> AnyHashable? 
```

### init(traitCollection:​)

Creates a View configuration state with the specified trait collection.

``` swift
init(traitCollection: TraitCollection)
```
