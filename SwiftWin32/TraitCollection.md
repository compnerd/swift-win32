---
layout: default
title: TraitCollection
parent: SwiftWin32
---
# TraitCollection

``` swift
public class TraitCollection 
```

## Initializers

### `init(traitsFrom:)`

``` swift
public init(traitsFrom traits: [TraitCollection]) 
```

### `init(userInterfaceStyle:)`

``` swift
public init(userInterfaceStyle: UserInterfaceStyle) 
```

### `init(userInterfaceIdiom:)`

``` swift
public init(userInterfaceIdiom: UserInterfaceIdiom) 
```

### `init(horizontalSizeClass:)`

``` swift
public init(horizontalSizeClass: UserInterfaceSizeClass) 
```

### `init(verticalSizeClass:)`

``` swift
public init(verticalSizeClass: UserInterfaceSizeClass) 
```

### `init(accessibilityContrast:)`

``` swift
public init(accessibilityContrast: AccessibilityContrast) 
```

### `init(userInterfaceLevel:)`

``` swift
public init(userInterfaceLevel: UserInterfaceLevel) 
```

### `init(legibilityWeight:)`

``` swift
public init(legibilityWeight: LegibilityWeight) 
```

### `init(activeAppearance:)`

``` swift
public init(activeAppearance: UserInterfaceActiveAppearance) 
```

### `init(forceTouchCapability:)`

``` swift
public init(forceTouchCapability: ForceTouchCapability) 
```

### `init(displayScale:)`

``` swift
public init(displayScale: Double) 
```

### `init(displayGamut:)`

``` swift
public init(displayGamut: DisplayGamut) 
```

### `init(layoutDirection:)`

``` swift
public init(layoutDirection: TraitEnvironmentLayoutDirection) 
```

### `init(preferredContentSizeCategory:)`

``` swift
public init(preferredContentSizeCategory: ContentSizeCategory) 
```

## Properties

### `current`

``` swift
public private(set) static var current: TraitCollection 
```

### `horizontalSizeClass`

``` swift
public private(set) var horizontalSizeClass: UserInterfaceSizeClass =
      .unspecified
```

### `verticalSizeClass`

``` swift
public private(set) var verticalSizeClass: UserInterfaceSizeClass =
      .unspecified
```

### `displayScale`

``` swift
public private(set) var displayScale: Double = 0.0
```

### `displayGamut`

``` swift
public private(set) var displayGamut: DisplayGamut = .unspecified
```

### `userInterfaceStyle`

``` swift
public private(set) var userInterfaceStyle: UserInterfaceStyle = .unspecified
```

### `userInterfaceIdiom`

``` swift
public private(set) var userInterfaceIdiom: UserInterfaceIdiom = .unspecified
```

### `userInterfaceLevel`

``` swift
public private(set) var userInterfaceLevel: UserInterfaceLevel = .unspecified
```

### `layoutDirection`

``` swift
public private(set) var layoutDirection: TraitEnvironmentLayoutDirection =
      .unspecified
```

### `accessibilityContrast`

``` swift
public private(set) var accessibilityContrast: AccessibilityContrast =
      .unspecified
```

### `legibilityWeight`

``` swift
public private(set) var legibilityWeight: LegibilityWeight = .unspecified
```

### `activeAppearance`

``` swift
public private(set) var activeAppearance: UserInterfaceActiveAppearance =
      .unspecified
```

### `forceTouchCapability`

``` swift
public private(set) var forceTouchCapability: ForceTouchCapability =
      .unspecified
```

### `preferredContentSizeCategory`

``` swift
public private(set) var preferredContentSizeCategory: ContentSizeCategory =
      .unspecified
```
