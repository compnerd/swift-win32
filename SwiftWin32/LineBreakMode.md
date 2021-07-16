---
layout: default
title: LineBreakMode
parent: SwiftWin32
---
# LineBreakMode

Constants that specify what happens when a line is too long for its
container.

``` swift
public enum LineBreakMode: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `byWordWrapping`

Wrapping occurs at word boundaries, unless the word doesn’t fit on a
single line.

``` swift
case byWordWrapping
```

### `byCharWrapping`

Wrapping occurs before the first character that doesn’t fit.

``` swift
case byCharWrapping
```

### `byClipping`

Lines don't extend past the edge of the text container.

``` swift
case byClipping
```

### `byTruncatingHead`

The line displays so that the end fits in the container and an ellipsis
glyph indicates the missing text at the beginning of the line.

``` swift
case byTruncatingHead
```

### `byTruncatingTail`

The line displays so that the beginning fits in the container and an
ellipsis glyph indicates the missing text at the end of the line.

``` swift
case byTruncatingTail
```

### `byTruncatingMiddle`

The line displays so that the beginning and end fit in the container and
an ellipsis glyph indicates the missing text in the middle.

``` swift
case byTruncatingMiddle
```
