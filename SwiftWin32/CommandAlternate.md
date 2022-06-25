---
layout: default
title: CommandAlternate
parent: SwiftWin32
---
# CommandAlternate

An object representing an alternative action for a command.

``` swift
public class CommandAlternate 
```

## Initializers

### `init(title:action:modifierFlags:)`

Creates a command alternative with the specified title, action, and
modifier flags.

``` swift
public /*convenience*/ init(title: String,
                              action: @escaping (_: AnyObject?) -> Void,
                              modifierFlags: KeyModifierFlags) 
```

## Properties

### `title`

The command alternative's title.

``` swift
public private(set) var title: String
```

### `action`

The command alternative's action-method selector.

``` swift
public private(set) var action: (_: AnyObject?) -> Void
```

### `modifierFlags`

The bit mask of modifier keys that the user must press to invoke the
action for the alternative command.

``` swift
public private(set) var modifierFlags: KeyModifierFlags
```
