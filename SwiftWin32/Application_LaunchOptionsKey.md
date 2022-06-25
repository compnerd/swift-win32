---
layout: default
title: Application.LaunchOptionsKey
parent: SwiftWin32
---
# Application.LaunchOptionsKey

Keys used to access values in the launch options dictionary passed to your
application at initialization time.

``` swift
public struct LaunchOptionsKey: Equatable, Hashable, RawRepresentable 
```

## Inheritance

`Equatable`, `Hashable`, `RawRepresentable`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = String
```

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: RawValue) 
```

## Properties

### `rawValue`

``` swift
public var rawValue: RawValue
```

### `annotation`

A key indicating that the URL passed to your application contains custom
annotation data from the source application.

``` swift
public static var annotation: Application.LaunchOptionsKey 
```

### `bluetoothCentrals`

A key indicating that the application was relaunched to handle
bluetooth-related events.

``` swift
public static var bluetoothCentrals: Application.LaunchOptionsKey 
```

### `bluetoothPeripherals`

A key indicating that the application should continue actions associated
with it's bluetooth peripheral objects.

``` swift
public static var bluetoothPeripherals: Application.LaunchOptionsKey 
```

### `location`

A key indicating that the application was launched to handle an incoming
location event.

``` swift
public static var location: Application.LaunchOptionsKey 
```

### `remoteNotification`

A key indicating that a remove notification is available for the
application to process.

``` swift
public static var remoteNotification: Application.LaunchOptionsKey 
```

### `shortcutItem`

A key indicating that the application was launched in response to the user
selecting a quick action.

``` swift
public static var shortcutItem: Application.LaunchOptionsKey 
```

### `sourceApplication`

A key indicating that another application rrequested the launch of your
application.

``` swift
public static var sourceApplication: Application.LaunchOptionsKey 
```

### `url`

A key indicating that the application was launched so it could open the
specified URL.

``` swift
public static var url: Application.LaunchOptionsKey 
```

### `userActivityDictionary`

A key indicating a dictionary associated with an activity that the user
wants to continue.

``` swift
public static var userActivityDictionary: Application.LaunchOptionsKey 
```

### `userActivityType`

A key indicating the type of user activity that the user wants to
continue.

``` swift
public static var userActivityType: Application.LaunchOptionsKey 
```
