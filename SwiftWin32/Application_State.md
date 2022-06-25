---
layout: default
title: Application.State
parent: SwiftWin32
---
# Application.State

The running states of the application

``` swift
public enum State: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `active`

The application is running in the foreground and currently receiving
events.

``` swift
case active
```

### `inactive`

The application is running in the foreground but is not receiving events.

``` swift
case inactive
```

### `background`

The application is running in the background.

``` swift
case background
```
