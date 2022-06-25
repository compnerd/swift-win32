---
layout: default
title: Event.EventSubtype
parent: SwiftWin32
---
# Event.EventSubtype

Specifies the subtype of the event in relation to its general type.

``` swift
public enum EventSubtype: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `none`

The event has no subtype.

``` swift
case none
```

### `motionShake`

The event is related to the user shaking the device.

``` swift
case motionShake
```

### `remoteControlPlay`

A remote-control event for playing audio or video.

``` swift
case remoteControlPlay
```
