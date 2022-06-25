---
layout: default
title: ContentSizeCategory
parent: SwiftWin32
---
# ContentSizeCategory

Constants that indicate the preferred size of your content.

``` swift
public struct ContentSizeCategory: Equatable, Hashable, RawRepresentable 
```

## Inheritance

`Equatable`, `Hashable`, `RawRepresentable`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = String
```

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: RawValue) 
```

## Properties

### `rawValue`

``` swift
public var rawValue: RawValue
```

### `unspecified`

An unspecified font size.

``` swift
public static var unspecified: ContentSizeCategory 
```

### `extraSmall`

An extra-small font.

``` swift
public static var extraSmall: ContentSizeCategory 
```

### `small`

A small font.

``` swift
public static var small: ContentSizeCategory 
```

### `medium`

A medium-sized font.

``` swift
public static var medium: ContentSizeCategory 
```

### `large`

A large font.

``` swift
public static var large: ContentSizeCategory 
```

### `extraLarge`

An extra-large font.

``` swift
public static var extraLarge: ContentSizeCategory 
```

### `extraExtraLarge`

A font that is larger than the extra-large font but smaller than the
largest font size available.

``` swift
public static var extraExtraLarge: ContentSizeCategory 
```

### `extraExtraExtraLarge`

The largest font size.

``` swift
public static var extraExtraExtraLarge: ContentSizeCategory 
```

### `accessibilityMedium`

A medium font size that reflects the current accessibility settings.

``` swift
public static var accessibilityMedium: ContentSizeCategory 
```

### `accessibilityLarge`

A large font size that reflects the current accessibility settings.

``` swift
public static var accessibilityLarge: ContentSizeCategory 
```

### `accessibilityExtraLarge`

An extra-large font size that reflects the current accessibility settings.

``` swift
public static var accessibilityExtraLarge: ContentSizeCategory 
```

### `accessibilityExtraExtraLarge`

A font that is larger than the extra-large font but not the largest
available, reflecting the current accessibility settings.

``` swift
public static var accessibilityExtraExtraLarge: ContentSizeCategory 
```

### `accessibilityExtraExtraExtraLarge`

The largest font size that reflects the current accessibility settings.

``` swift
public static var accessibilityExtraExtraExtraLarge: ContentSizeCategory 
```

### `didChangeNotification`

A notification that posts when the user changes the preferred content size
setting.

``` swift
public static var didChangeNotification: NSNotification.Name 
```

This notification is sent when the value in the
`preferredContentSizeCategory` property changes. The `userInfo` dictionary
of the notification contains the `newValueUserInfoKey` key, which reflects
the new setting.

### `newValueUserInfoKey`

A key that reflects the new preferred content size.

``` swift
public static var newValueUserInfoKey: String 
```

This key's value is an `NSString` object that reflects the new value of
the `preferredContentSizeCategory` property.
