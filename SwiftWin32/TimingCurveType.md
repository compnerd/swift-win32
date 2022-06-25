---
layout: default
title: TimingCurveType
parent: SwiftWin32
---
# TimingCurveType

Constants indicating the type of timing information to use.

``` swift
public enum TimingCurveType: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `builtin`

Use the built-in timing curves. Specify this value when you want to use
one of the constants in the `View.AnimationCurve` type. Specify the
desired curve using the `cubicTimingParameters` property.

``` swift
case builtin
```

### `cubic`

Use a custom cubic Bézier curve. Specify the curve information using the
`cubicTimingParameters` property.

``` swift
case cubic
```

### `spring`

Use a custom spring animation. Specify the desired curve using the
`springTimingParameters` property.

``` swift
case spring
```

### `composed`

Use a combination of timing parameters. This type of curve starts with the
curve defined by the `cubicTimingParameters` property and modifies it
using the spring information in the `springTimingParameters` property.

``` swift
case composed
```
