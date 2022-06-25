---
layout: default
title: ModalTransitionStyle
parent: SwiftWin32
---
# ModalTransitionStyle

Transition styles available when presenting view controllers.

``` swift
public enum ModalTransitionStyle: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `coverVertical`

When the view controller is presented, its view slides up from the bottom
of the screen. On dismissal, the view slides back down. This is the
default transition style.

``` swift
case coverVertical
```

### `flipHorizontal`

When the view controller is presented, the current view initiates a
horizontal 3D flip from right-to-left, resulting in the revealing of the
new view as if it were on the back of the previous view. On dismissal, the
flip occurs from left-to-right, returning to the original view.

``` swift
case flipHorizontal
```

### `crossDissolve`

When the view controller is presented, the current view fades out while
the new view fades in at the same time. On dismissal, a similar type of
cross-fade is used to return to the original view.

``` swift
case crossDissolve
```

### `partialCurl`

When the view controller is presented, one corner of the current view
curls up to reveal the presented view underneath. On dismissal, the curled
up page unfurls itself back on top of the presented view. A view
controller presented using this transition is itself prevented from
presenting any additional view controllers.

``` swift
case partialCurl
```

This transition style is supported only if the parent view controller is
presenting a full-screen view and you use the
`ModalPresentationStyle.fullScreen` modal presentation style. Attempting
to use a different form factor for the parent view or a different
presentation style triggers an exception.
