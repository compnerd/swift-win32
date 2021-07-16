---
layout: default
title: ContextMenuInteractionAnimating
parent: SwiftWin32
---
# ContextMenuInteractionAnimating

Methods adopted by system-supplied animator objects when interacting with
context menus.

``` swift
public protocol ContextMenuInteractionAnimating 
```

## Requirements

### addAnimations(\_:​)

Adding Custom Animations
Adds the specified animation block to the animator.

``` swift
func addAnimations(_ animations: @escaping () -> Void)
```

### addCompletion(\_:​)

Adds the specified completion block to the animator.

``` swift
func addCompletion(_ completion: @escaping () -> Void)
```

### previewViewController

Previewing the Content
The current preview controller.

``` swift
var previewViewController: ViewController? 
```
