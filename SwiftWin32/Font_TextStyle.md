---
layout: default
title: Font.TextStyle
parent: SwiftWin32
---
# Font.TextStyle

Constants that describe the preferred styles for fonts.

``` swift
struct TextStyle: Hashable, Equatable, RawRepresentable 
```

## Inheritance

`Equatable`, `Hashable`, `RawRepresentable`

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: String) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: String
```

### `body`

The font for body text.

``` swift
static var body: Font.TextStyle 
```

### `callout`

The font for callouts.

``` swift
static var callout: Font.TextStyle 
```

### `caption1`

The font for standard captions.

``` swift
static var caption1: Font.TextStyle 
```

### `caption2`

The font for alternate captions.

``` swift
static var caption2: Font.TextStyle 
```

### `footnote`

The font for footnotes.

``` swift
static var footnote: Font.TextStyle 
```

### `headline`

The font for headings.

``` swift
static var headline: Font.TextStyle 
```

### `subheadline`

The font for subheadings.

``` swift
static var subheadline: Font.TextStyle 
```

### `largeTitle`

The font style for large titles.

``` swift
static var largeTitle: Font.TextStyle 
```

### `title1`

The font for first-level hierarchical headings.

``` swift
static var title1: Font.TextStyle 
```

### `title2`

The font for second-level hierarchical headings.

``` swift
static var title2: Font.TextStyle 
```

### `title3`

The font for third-level hierarchical headings.

``` swift
static var title3: Font.TextStyle 
```
