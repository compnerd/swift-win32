---
layout: default
title: UIApplicationDelegateAdaptor
parent: SwiftWin32UI
---
# UIApplicationDelegateAdaptor

A property wrapper that is used in `App` to provide an application delegate
from Swift/Win32.

``` swift
@propertyWrapper
public struct UIApplicationDelegateAdaptor<DelegateType: ApplicationDelegate> 
```

## Initializers

### `init(_:)`

Creates an `UIApplicationDelegateAdaptor` using an ApplicationDelegate.

``` swift
public init(_ delegateType: DelegateType.Type = DelegateType.self) 
```

## Properties

### `wrappedValue`

The underlying delegate.

``` swift
public private(set) var wrappedValue: DelegateType
```
