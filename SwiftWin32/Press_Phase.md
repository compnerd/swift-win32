---
layout: default
title: Press.Phase
parent: SwiftWin32
---
# Press.Phase

The phases of a button press.

``` swift
public enum Phase: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `began`

A physical button was pressed.

``` swift
case began
```

### `changed`

A button moved, or the `force` property changed.

``` swift
case changed
```

### `stationary`

A button was pressed but hasn’t moved since the previous event.

``` swift
case stationary
```

### `ended`

A button was released.

``` swift
case ended
```

### `cancelled`

The system canceled tracking for the button.

``` swift
case cancelled
```
