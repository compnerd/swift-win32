---
layout: default
title: SpringLoadedInteractionContext
parent: SwiftWin32
---
# SpringLoadedInteractionContext

The interface an object implements to provide information about a
spring-loaded interaction.

``` swift
public protocol SpringLoadedInteractionContext 
```

## Requirements

### state

The current view style for the string-loaded interaction.

``` swift
var state: SpringLoadedInteractionEffectState 
```

### targetItem

The specific subview, or associated model object, of the target view to
use for the spring-loaded interaction.

``` swift
var targetItem: Any? 
```

### targetView

The view to which the current spring-loaded interaction view style is
applied.

``` swift
var targetView: View? 
```
