---
layout: default
title: ModalPresentationStyle
parent: SwiftWin32
---
# ModalPresentationStyle

Modal presentation styles available when presenting view controllers.

``` swift
public enum ModalPresentationStyle: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `automatic`

The default presentation style chosen by the system.

``` swift
case automatic
```

### `none`

A presentation style that indicates no adaptations should be made.

``` swift
case none
```

### `fullScreen`

A presentation style in which the presented view covers the screen.

``` swift
case fullScreen
```

### `pageSheet`

A presentation style that partially covers the underlying content.

``` swift
case pageSheet
```

### `formSheet`

A presentation style that displays the content centered in the screen.

``` swift
case formSheet
```

### `currentContext`

A presentation style where the content is displayed over another view
controller's content.

``` swift
case currentContext
```

### `custom`

A custom view presentation style that is managed by a custom presentation
controller and one or more custom animator objects.

``` swift
case custom
```

### `overFullScreen`

A view presentation style in which the presented view covers the screen.

``` swift
case overFullScreen
```

### `overCurrentContext`

A presentation style where the content is displayed over another view
controller's content.

``` swift
case overCurrentContext
```

### `popover`

A presentation style where the content is displayed in a popover view.

``` swift
case popover
```

### `blurOverFullScreen`

A presentation style that blurs the underlying content before displaying new
content in a full-screen presentation.

``` swift
case blurOverFullScreen
```
