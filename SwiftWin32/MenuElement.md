---
layout: default
title: MenuElement
parent: SwiftWin32
---
# MenuElement

An object representing a menu, action, or command.

``` swift
open class MenuElement 
```

## Initializers

### `init(title:image:)`

Creates and returns a `MenuElement` initialized with the given title and
image.

``` swift
public init(title: String, image: Image? = nil) 
```

## Properties

### `title`

The title of the menu element.

``` swift
open internal(set) var title: String
```

### `image`

The image to display alongside the menu element's title.

``` swift
open internal(set) var image: Image?
```
