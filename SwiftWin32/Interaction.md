---
layout: default
title: Interaction
parent: SwiftWin32
---
# Interaction

The protocol that an interaction implements to access the view that owns it.

``` swift
public protocol Interaction: AnyObject 
```

## Inheritance

`AnyObject`

## Requirements

### view

The view that owns the interaction.

``` swift
var view: View? 
```

### didMove(to:​)

Tells the interaction that a view added or removed it from the view's
interaction array.

``` swift
func didMove(to view: View?)
```

### willMove(to:​)

Tells the interaction that a view will add or remove it from the view's
interaction array.

``` swift
func willMove(to view: View?)
```
