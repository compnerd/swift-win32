---
layout: default
title: SceneSession
parent: SwiftWin32
---
# SceneSession

``` swift
public class SceneSession 
```

## Inheritance

`Hashable`

## Properties

### `scene`

The scene associated with the current session.

``` swift
public internal(set) weak var scene: Scene?
```

### `role`

The role played by the scene's content.

``` swift
public let role: SceneSession.Role
```

### `configuration`

The configuration data for creating the secene.

``` swift
public internal(set) var configuration: SceneConfiguration
```

### `persistentIdentifier`

A unique identifier that persists for the lifetime of the session

``` swift
public let persistentIdentifier: String
```

## Methods

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func == (lhs: SceneSession, rhs: SceneSession) -> Bool 
```
