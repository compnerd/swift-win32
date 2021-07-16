---
layout: default
title: App
parent: SwiftWin32UI
---
# App

A type that represents the structure and behaviour of an application.

``` swift
public protocol App 
```

## Default Implementations

### `main()`

``` swift
public static func main() 
```

## Requirements

### Body

The type of scene representing the content of the application.

``` swift
associatedtype Body: Scene
```

### body

The content and behaviour of the application.

``` swift
@SceneBuilder
  var body: Self.Body 
```

### init()

Creates an instance of the application using the body as the content.

``` swift
init()
```

### main()

Initializes and runs the application.

``` swift
static func main()
```
