---
layout: default
title: Font
parent: SwiftWin32
---
# Font

Represents a font.

``` swift
public class Font 
```

## Initializers

### `init?(name:size:)`

Creates an returns a font object for the specified font name and size.

``` swift
public init?(name: String, size: Double) 
```

## Properties

### `familyNames`

Returns an array of font family names available on the system.

``` swift
public static var familyNames: [String] 
```

### `fontName`

The font face name.

``` swift
public var fontName: String 
```

### `pointSize`

The font's point size, or the effective vertical point size for a font
with a non-standard matrix.

``` swift
public var pointSize: Double 
```

### `ascender`

The top y-coordinate, offset from the baseline, of the font's longest
ascender.

``` swift
public var ascender: Double 
```

### `descender`

The bottom y-coordinate, offset from the baseline, of the font's longest
descender.

``` swift
public var descender: Double 
```

### `leading`

The font's leading information.

``` swift
public var leading: Double 
```

### `capHeight`

The font's cap height information.

``` swift
public var capHeight: Double 
```

### `xHeight`

The x-height of the font.

``` swift
public var xHeight: Double 
```

### `labelFontSize`

The height, in points, of text lines.
The standard font size, in points, for labels.

``` swift
public static var labelFontSize: Double 
```

### `buttonFontSize`

The standard font size, in points, for buttons.

``` swift
public static var buttonFontSize: Double 
```

### `smallSystemFontSize`

The size, in points, of the standard small system font.

``` swift
public static var smallSystemFontSize: Double 
```

### `systemFontSize`

The size, in points, of the standard system font.

``` swift
public static var systemFontSize: Double 
```

## Methods

### `preferredFont(forTextStyle:)`

Returns an instance of the system font for the specified text style with
scaling for the user's selected content size category.

``` swift
public static func preferredFont(forTextStyle style: Font.TextStyle) -> Font 
```

### `preferredFont(forTextStyle:compatibleWith:)`

Returns an instance of the system font for the appropriate text style and
traits.

``` swift
public static func preferredFont(forTextStyle style: Font.TextStyle,
                                   compatibleWith traits: TraitCollection?)
      -> Font 
```

### `withSize(_:)`

``` swift
public func withSize(_ fontSize: Double) -> Font 
```

### `systemFont(ofSize:)`

Returns the font object for standard interface items in the specified
size.

``` swift
public static func systemFont(ofSize fontSize: Double) -> Font 
```

### `systemFont(ofSize:weight:)`

Returns the font object for standard interface items in the specifed size
and weight.

``` swift
public static func systemFont(ofSize fontSize: Double, weight: Font.Weight)
      -> Font 
```

### `boldSystemFont(ofSize:)`

Returns the font object for standard interface items in boldface type in
the specified size.

``` swift
public static func boldSystemFont(ofSize fontSize: Double) -> Font 
```

### `italicSystemFont(ofSize:)`

Returns the font object for standard interface items in italic type in the
specified size.

``` swift
public static func italicSystemFont(ofSize fontSize: Double) -> Font 
```

### `monospacedSystemFont(ofSize:weight:)`

Returns the fixed-width font for standard interface text in the specified
size.

``` swift
public static func monospacedSystemFont(ofSize fontSize: Double,
                                          weight: Font.Weight) -> Font 
```

### `monospacedDigitSystemFont(ofSize:weight:)`

Returns the standard system font with all digits of consistent width.

``` swift
public static func monospacedDigitSystemFont(ofSize fontSize: Double,
                                               weight: Font.Weight) -> Font 
```

### `fontNames(forFontFamily:)`

Returns an array of font names available in a particular font family.

``` swift
public static func fontNames(forFontFamily family: String) -> [String] 
```
