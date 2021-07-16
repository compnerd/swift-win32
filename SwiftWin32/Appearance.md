---
layout: default
title: Appearance
parent: SwiftWin32
---
# Appearance

A collection of methods that gives you access to the appearance proxy for a
class.

``` swift
public protocol Appearance 
```

## Requirements

### appearance()

Returns the appearance proxy for the receiver.

``` swift
static func appearance() -> Self
```

### appearance(for:​)

Returns the appearance proxy for the receiver that has the passed trait
collection.

``` swift
static func appearance(for trait: TraitCollection) -> Self
```

### appearance(whenContainedInInstancesOf:​)

Returns the appearance proxy for the object when it is contained in the
hierarchy the specified classes describe.

``` swift
static func appearance(whenContainedInInstancesOf containerTypes: [AppearanceContainer.Type])
      -> Self
```

### appearance(for:​whenContainedInInstancesOf:​)

Returns the appearance proxy for the object when it is contained in the
hierarchy the specified classes describe and has the specified trait
collection.

``` swift
static func appearance(for trait: TraitCollection,
                         whenContainedInInstancesOf containerTypes: [AppearanceContainer.Type]) -> Self
```
