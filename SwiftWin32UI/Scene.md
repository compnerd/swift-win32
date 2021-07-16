---
layout: default
title: Scene
parent: SwiftWin32UI
---
# Scene

A part of the application's user interface.

``` swift
public protocol Scene 
```

## Requirements

### Body

The type of scene representing the body of this scene.

``` swift
associatedtype Body: Scene
```

### body

The content and behaviour of the scene.

``` swift
@SceneBuilder
  var body: Self.Body 
```
