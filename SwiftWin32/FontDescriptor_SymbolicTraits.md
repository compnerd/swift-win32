---
layout: default
title: FontDescriptor.SymbolicTraits
parent: SwiftWin32
---
# FontDescriptor.SymbolicTraits

Constants that describe the stylistic aspects of a font.

``` swift
public struct SymbolicTraits: OptionSet 
```

## Inheritance

`OptionSet`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = UInt32
```

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: RawValue) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `traitItalic`

The font's style is italic.

``` swift
public static var traitItalic: FontDescriptor.SymbolicTraits 
```

### `traitBold`

The font's style is bold.

``` swift
public static var traitBold: FontDescriptor.SymbolicTraits 
```

### `traitExpanded`

The font's characters have an expanded width.

``` swift
public static var traitExpanded: FontDescriptor.SymbolicTraits 
```

### `traitCondensed`

The font's characters have a condensed width.

``` swift
public static var traitCondensed: FontDescriptor.SymbolicTraits 
```

### `traitMonoSpace`

The font's characters all have the same width.

``` swift
public static var traitMonoSpace: FontDescriptor.SymbolicTraits 
```

### `traitVertical`

The font uses vertical glyph variants and metrics.

``` swift
public static var traitVertical: FontDescriptor.SymbolicTraits 
```

### `traitUIOptimized`

The font synthesizes appropriate attributes for user interface rendering,
such as in control titles, if necessary.

``` swift
public static var traitUIOptimized: FontDescriptor.SymbolicTraits 
```

### `traitTightLeading`

The font uses a leading value that's less than the default.

``` swift
public static var traitTightLeading: FontDescriptor.SymbolicTraits 
```

### `traitLooseLeading`

The font uses a leading value that’s greater than the default.

``` swift
public static var traitLooseLeading: FontDescriptor.SymbolicTraits 
```

### `classMask`

The font family class mask that you use to access font descriptor values.

``` swift
public static var classMask: FontDescriptor.SymbolicTraits 
```

### `classOldStyleSerifs`

The font's characters include serifs, and reflect the Latin printing style
of the 15th to 17th centuries.

``` swift
public static var classOldStyleSerifs: FontDescriptor.SymbolicTraits 
```

### `classTransitionalSerifs`

The font's characters include serifs, and reflect the Latin printing style
of the 18th to 19th centuries.

``` swift
public static var classTransitionalSerifs: FontDescriptor.SymbolicTraits 
```

### `classModernSerifs`

The font's characters include serifs, and reflect the Latin printing style
of the 20th century.

``` swift
public static var classModernSerifs: FontDescriptor.SymbolicTraits 
```

### `classClarendonSerifs`

The font's characters include variations of old style and transitional
serifs.

``` swift
public static var classClarendonSerifs: FontDescriptor.SymbolicTraits 
```

### `classSlabSerifs`

The font's characters use square transitions, without brackets, between
strokes and serifs.

``` swift
public static var classSlabSerifs: FontDescriptor.SymbolicTraits 
```

### `classFreeformSerifs`

The font's characters include serifs, and don’t generally fit within other
serif design classifications.

``` swift
public static var classFreeformSerifs: FontDescriptor.SymbolicTraits 
```

### `classSansSerif`

The font's characters don’t have serifs.

``` swift
public static var classSansSerif: FontDescriptor.SymbolicTraits 
```

### `classOrnamentals`

The font's characters use highly decorated or stylized character shapes.

``` swift
public static var classOrnamentals: FontDescriptor.SymbolicTraits 
```

### `classScripts`

The font's characters simulate handwriting.

``` swift
public static var classScripts: FontDescriptor.SymbolicTraits 
```

### `classSymbolic`

The font's characters consist mainly of symbols rather than letters and
numbers.

``` swift
public static var classSymbolic: FontDescriptor.SymbolicTraits 
```
