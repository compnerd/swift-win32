---
layout: default
title: SceneConfiguration
parent: SwiftWin32
---
# SceneConfiguration

``` swift
public class SceneConfiguration 
```

## Inheritance

`Hashable`

## Initializers

### `init(name:sessionRole:)`

Creating a Configuration Object
Creates a scene-configuration object with the specified role and
application-specific name.

``` swift
public init(name: String?, sessionRole: SceneSession.Role) 
```

## Properties

### `sceneClass`

Specifying the Scene Creation Details
The class of the scene object you want to create.

``` swift
public var sceneClass: AnyClass?
```

### `delegateClass`

The class of the delegate object you want to create.

``` swift
public var delegateClass: AnyClass?
```

### `name`

Getting the Configuration Attributes
The application-specific name assigned to the scene configuration.

``` swift
public private(set) var name: String?
```

### `role`

The role assigned to the scene configuration.

``` swift
public let role: SceneSession.Role
```

## Methods

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func == (lhs: SceneConfiguration, rhs: SceneConfiguration)
      -> Bool 
```
