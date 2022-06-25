---
layout: default
title: FontDescriptor
parent: SwiftWin32
---
# FontDescriptor

A collection of attributes that describes a font.

``` swift
public class FontDescriptor 
```

## Nested Type Aliases

### `Class`

Constants that classify certain stylistic qualities of the font.

``` swift
public typealias Class = Int
```

## Initializers

### `init(name:matrix:)`

Returns a font descriptor with the specified values for name and matrix
dictionary attributes.

``` swift
public init(name fontName: String, matrix: AffineTransform) 
```

### `init(name:size:)`

Returns a font descriptor with the specified values for the name and size
dictionary attributes.

``` swift
public init(name fontName: String, size: Double) 
```

### `init(fontAttributes:)`

Initializing a Font Descriptor
Creates a font descriptor with the specified attributes.

``` swift
public init(fontAttributes attributes: [FontDescriptor.AttributeName:Any] = [:]) 
```

## Properties

### `fontAttributes`

Querying a Font Descriptor
The font descriptor's dictionary of attributes.

``` swift
public private(set) var fontAttributes: [FontDescriptor.AttributeName:Any] = [:]
```

### `matrix`

The current transform matrix of the font decriptor.

``` swift
public var matrix: AffineTransform 
```

### `pointSize`

The point size of the font descriptor.

``` swift
public var pointSize: Double 
```

### `postscriptName`

The PostScript name of the font descriptor.

``` swift
public var postscriptName: String 
```

### `symbolicTraits`

The traits of the font descriptor.

``` swift
public var symbolicTraits: FontDescriptor.SymbolicTraits 
```

## Methods

### `preferredFontDescriptor(withTextStyle:)`

Creating a Font Descriptor
Returns a font descriptor that contains the specified text style and the
user's selected content size category.

``` swift
public static func preferredFontDescriptor(withTextStyle style: Font.TextStyle)
      -> FontDescriptor 
```

### `preferredFontDescriptor(withTextStyle:compatibleWith:)`

Returns a font descriptor that contains the text style and the content
size category the provided trait collection specifies.

``` swift
public static func preferredFontDescriptor(withTextStyle style: Font.TextStyle,
                                             compatibleWith traitCollection: TraitCollection?)
      -> FontDescriptor 
```

### `addingAttributes(_:)`

Returns a new font descriptor that is the same as the existing descriptor,
but with the specified attributes taking precedence over the existing
ones.

``` swift
public func addingAttributes(_ attributes: [FontDescriptor.AttributeName:Any] = [:])
      -> FontDescriptor 
```

### `withDesign(_:)`

Returns a new font descriptor that is the same as the existing descriptor,
but with the specified design.

``` swift
public func withDesign(_ design: FontDescriptor.SystemDesign)
      -> FontDescriptor? 
```

### `withFamily(_:)`

Returns a new font descriptor that is the same as the existing descriptor,
but with the specified family.

``` swift
public func withFamily(_ newFamily: String) -> FontDescriptor 
```

### `withFace(_:)`

Returns a new font descriptor that is the same as the existing descriptor,
but with the specified font face.

``` swift
public func withFace(_ newFace: String) -> FontDescriptor 
```

### `withMatrix(_:)`

Returns a new font descriptor that is the same as the existing descriptor,
but with the specified matrix.

``` swift
public func withMatrix(_ matrix: AffineTransform) -> FontDescriptor 
```

### `withSize(_:)`

Returns a new font descriptor that is the same as the existing descriptor,
but with the specified size.

``` swift
public func withSize(_ newPointSize: Double) -> FontDescriptor 
```

### `withSymbolicTraits(_:)`

Returns a new font descriptor that is the same as the existing descriptor,
but with the specified symbolic traits.

``` swift
public func withSymbolicTraits(_ symbolicTraits: FontDescriptor.SymbolicTraits)
      -> FontDescriptor? 
```

### `matchingFontDescriptors(withMandatoryKeys:)`

Finding Fonts
Returns all the fonts available in the system with the specified
attributes.

``` swift
public func matchingFontDescriptors(withMandatoryKeys mandatoryKeys: Set<FontDescriptor.AttributeName>?)
      -> [FontDescriptor] 
```

### `object(forKey:)`

``` swift
public func object(forKey attribute: FontDescriptor.AttributeName) -> Any? 
```
