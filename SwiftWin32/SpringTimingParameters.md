---
layout: default
title: SpringTimingParameters
parent: SwiftWin32
---
# SpringTimingParameters

The timing information for animations that mimics the behavior of a spring.

``` swift
public class SpringTimingParameters 
```

## Initializers

### `init()`

Creates a default timing parameters object.

``` swift
public init() 
```

This method sets the initial velocity of any animated properties to 0.0
and sets the damping ratio to 4.56.

### `init(dampingRatio:)`

Creates a timing parameters object with the specified damping ratio.

``` swift
public convenience init(dampingRatio ratio: Double) 
```

This method sets the initial velocity of any animated properties to 0.0.

### `init(dampingRatio:initialVelocity:)`

Creates a timing parameters object with the specified damping ratio and
initial velocity.

``` swift
public init(dampingRatio ratio: Double, initialVelocity velocity: Vector) 
```

### `init(mass:stiffness:damping:initialVelocity:)`

Creates a timing parameters object with the specified spring stiffness,
mass, damping coefficient, and initial velocity.

``` swift
public init(mass: Double, stiffness: Double, damping: Double,
              initialVelocity velocity: Vector) 
```

The damping ratio for the spring is computed from the formula:
`damping / (2 * sqrt (stiffness * mass))`.

## Properties

### `initialVelocity`

The target property’s rate of change at the start of a spring animation,
enabling a smooth transition into the animation.

``` swift
public private(set) var initialVelocity: Vector
```
