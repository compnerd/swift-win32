---
layout: default
title: AlertAction.Style
parent: SwiftWin32
---
# AlertAction.Style

Styles to apply to action buttons in an alert.

``` swift
public enum Style: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `` `default` ``

Apply the default style to the action’s button.

``` swift
case `default`
```

### `cancel`

Apply a style that indicates the action cancels the operation and leaves
things unchanged.

``` swift
case cancel
```

### `destructive`

Apply a style that indicates the action might change or delete data.

``` swift
case destructive
```
