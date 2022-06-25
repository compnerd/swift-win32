---
layout: default
title: TimingCurveProvider
parent: SwiftWin32
---
# TimingCurveProvider

An interface for providing the timing information needed to perform
animations.

``` swift
public protocol TimingCurveProvider 
```

## Requirements

### timingCurveType

The type of timing information to use.

``` swift
var timingCurveType: TimingCurveType 
```

### cubicTimingParameters

The cubic timing parameters to use.

``` swift
var cubicTimingParameters: CubicTimingParameters? 
```

### springTimingParameters

The spring-based timing parameters to use.

``` swift
var springTimingParameters: SpringTimingParameters? 
```
