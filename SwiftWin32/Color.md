---
layout: default
title: Color
parent: SwiftWin32
---
# Color

An object that stores color data and sometimes opacity.

``` swift
public struct Color 
```

## Inheritance

`Equatable`, `Hashable`, `_ExpressibleByColorLiteral`

## Initializers

### `init(white:alpha:)`

Creates a color object using the specified opacity and grayscale values.

``` swift
public init(white: Double, alpha: Double) 
```

### `init(hue:saturation:brightness:alpha:)`

Creates a color object using the specified opacity and HSB color space
component values.

``` swift
public init(hue: Double, saturation: Double, brightness: Double,
              alpha: Double) 
```

### `init(red:green:blue:alpha:)`

Creates a color object using the specified opacity and RGB component
values.

``` swift
public init(red: Double, green: Double, blue: Double, alpha: Double) 
```

### `init(dynamicProvider:)`

Creates a color object that uses the specified block to generate its color
data dynamically.

``` swift
public init(dynamicProvider block: @escaping (TraitCollection) -> Color) 
```

### `init(_colorLiteralRed:green:blue:alpha:)`

``` swift
public init(_colorLiteralRed red: Float, green: Float, blue: Float,
              alpha: Float) 
```

## Properties

### `systemBlue`

A blue color that automatically adapts to the current trait environment.

``` swift
public static var systemBlue: Color 
```

### `systemBrown`

A brown color that automatically adapts to the current trait environment.

``` swift
public static var systemBrown: Color 
```

### `systemGreen`

A green color that automatically adapts to the current trait environment.

``` swift
public static var systemGreen: Color 
```

### `systemIndigo`

An indigo color that automatically adapts to the current trait
environment.

``` swift
public static var systemIndigo: Color 
```

### `systemOrange`

An orange color that automatically adapts to the current trait
environment.

``` swift
public static var systemOrange: Color 
```

### `systemPink`

A pink color that automatically adapts to the current trait environment.

``` swift
public static var systemPink: Color 
```

### `systemPurple`

A purple color that automatically adapts to the current trait environment.

``` swift
public static var systemPurple: Color 
```

### `systemRed`

A red color that automatically adapts to the current trait environment.

``` swift
public static var systemRed: Color 
```

### `systemTeal`

A teal color that automatically adapts to the current trait environment.

``` swift
public static var systemTeal: Color 
```

### `systemYellow`

A yellow color that automatically adapts to the current trait environment.

``` swift
public static var systemYellow: Color 
```

### `systemGray`

The standard base gray color that adapts to the environment.

``` swift
public static var systemGray: Color 
```

### `systemGray2`

A second-level shade of grey that adapts to the environment.

``` swift
public static var systemGray2: Color 
```

### `systemGray3`

A third-level shade of grey that adapts to the environment.

``` swift
public static var systemGray3: Color 
```

### `systemGray4`

A fourth-level shade of grey that adapts to the environment.

``` swift
public static var systemGray4: Color 
```

### `systemGray5`

A fifth-level shade of grey that adapts to the environment.

``` swift
public static var systemGray5: Color 
```

### `systemGray6`

A sixth-level shade of grey that adapts to the environment.

``` swift
public static var systemGray6: Color 
```

### `clear`

A color object with grayscale and alpha values that are both 0.0.

``` swift
public static var clear: Color 
```

### `black`

A color object in the sRGB color space with a grayscale value of 0.0 and
an alpha value of 1.0.

``` swift
public static var black: Color 
```

### `blue`

A color object with RGB values of 0.0, 0.0, and 1.0, and an alpha value of
1.0.

``` swift
public static var blue: Color 
```

### `brown`

A color object with RGB values of 0.6, 0.4, and 0.2, and an alpha value of
1.0.

``` swift
public static var brown: Color 
```

### `cyan`

A color object with RGB values of 0.0, 1.0, and 1.0, and an alpha value of
1.0.

``` swift
public static var cyan: Color 
```

### `darkGray`

A color object with a grayscale value of 1/3 and an alpha value of 1.0.

``` swift
public static var darkGray: Color 
```

### `gray`

A color object with a grayscale value of 0.5 and an alpha value of 1.0.

``` swift
public static var gray: Color 
```

### `green`

A color object with RGB values of 0.0, 1.0, and 0.0, and an alpha value of
1.0.

``` swift
public static var green: Color 
```

### `lightGray`

A color object with a grayscale value of 2/3 and an alpha value of 1.0.

``` swift
public static var lightGray: Color 
```

### `magenta`

A color object with RGB values of 1.0, 0.0, and 1.0, and an alpha value of
1.0.

``` swift
public static var magenta: Color 
```

### `orange`

A color object with RGB values of 1.0, 0.5, and 0.0, and an alpha value of
1.0.

``` swift
public static var orange: Color 
```

### `purple`

A color object with RGB values of 0.5, 0.0, and 0.5, and an alpha value of
1.0.

``` swift
public static var purple: Color 
```

### `red`

A color object with RGB values of 1.0, 0.0, and 0.0, and an alpha value of
1.0.

``` swift
public static var red: Color 
```

### `white`

A color object with a grayscale value of 1.0 and an alpha value of 1.0.

``` swift
public static var white: Color 
```

### `yellow`

A color object with RGB values of 1.0, 1.0, and 0.0, and an alpha value of
1.0.

``` swift
public static var yellow: Color 
```

### `label`

The Color for text labels that contain primary content.

``` swift
public static var label: Color 
```

### `secondaryLabel`

The color for text labels that contain secondary content.

``` swift
public static var secondaryLabel: Color 
```

### `tertiaryLabel`

The color for text labels that contain tertiary content.

``` swift
public static var tertiaryLabel: Color 
```

### `quatenaryLabel`

The color for text labels that contain quatenary content.

``` swift
public static var quatenaryLabel: Color 
```

### `systemFill`

An overlay fill color for thin and small shapes.

``` swift
public static var systemFill: Color 
```

### `secondarySystemFill`

An overlay fill color for medium-size shapes.

``` swift
public static var secondarySystemFill: Color 
```

### `tertiarySystemFill`

An overlay fill color for large shapes.

``` swift
public static var tertiarySystemFill: Color 
```

### `quaternarySystemFill`

An overlay fill color for large areas that contain complex content.

``` swift
public static var quaternarySystemFill: Color 
```

### `placeholderText`

The color for placeholder text in controls or text views.

``` swift
public static var placeholderText: Color 
```

### `systemBackground`

Standard Content Background Colors

``` swift
public static var systemBackground: Color 
```

Use these colors for standard table views and designs that have a white
primary background in a light environment.
The color for the main background of your interface.

### `secondarySystemBackground`

The color for content layered on top of the main background.

``` swift
public static var secondarySystemBackground: Color 
```

### `tertiarySystemBackground`

The color for content layered on top of secondary backgrounds.

``` swift
public static var tertiarySystemBackground: Color 
```

### `systemGroupedBackground`

Grouped Content Background Colors

``` swift
public static var systemGroupedBackground: Color 
```

Use these colors for grouped content, including table views and
platter-based designs.
The color for the main background of your grouped interface.

### `secondarySystemGroupedBackground`

The color for content layered on top of the main background of your
grouped interface.

``` swift
public static var secondarySystemGroupedBackground: Color 
```

### `tertiarySystemGroupedBackground`

The color for content layered on top of secondary backgrounds of your
grouped interface.

``` swift
public static var tertiarySystemGroupedBackground: Color 
```

### `separator`

The color for thin borders or divider lines that allows some underlying
content to be visible.

``` swift
public static var separator: Color 
```

### `opaqueSeparator`

The color for borders or divider lines that hides any underlying content.

``` swift
public static var opaqueSeparator: Color 
```

### `link`

The color for links.

``` swift
public static var link: Color 
```

### `darkText`

The nonadaptable system color for text on a light background.

``` swift
public static var darkText: Color 
```

### `lightText`

The nonadaptable system color for text on a dark background.

``` swift
public static var lightText: Color 
```

## Methods

### `getHue(_:saturation:brightness:alpha:)`

Returns the components that form the color in the HSB color space.

``` swift
public func getHue(_ hue: UnsafeMutablePointer<Double>?,
                     saturation: UnsafeMutablePointer<Double>?,
                     brightness: UnsafeMutablePointer<Double>?,
                     alpha: UnsafeMutablePointer<Double>?) -> Bool 
```

If the color is in a compatible color space, it converts into the HSB
color space, and its components return to your application. If the color
isn’t in a compatible color space, the parameters don’t change.

### `getRed(_:green:blue:alpha:)`

Returns the components that form the color in the RGB color space.

``` swift
public func getRed(_ red: UnsafeMutablePointer<Double>?,
                     green: UnsafeMutablePointer<Double>?,
                     blue: UnsafeMutablePointer<Double>?,
                     alpha: UnsafeMutablePointer<Double>?) -> Bool 
```

If the color is in a compatible color space, it converts into RGB format
and its components return to your application. If the color isn’t in a
compatible color space, the parameters don’t change.

### `getWhite(_:alpha:)`

Returns the grayscale components of the color.

``` swift
public func getWhite(_ white: UnsafeMutablePointer<Double>?,
                       alpha: UnsafeMutablePointer<Double>?) -> Bool 
```

If the color is in a compatible color space, it converts into grayscale
format and its returned to your application. If the color isn’t in a
compatible color space, the parameters don’t change.

### `resolvedColor(with:)`

Returns the version of the current color that results from the specified
traits.

``` swift
public func resolvedColor(with traitCollection: TraitCollection) -> Color 
```

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func ==(lhs: Color, rhs: Color) -> Bool 
```
