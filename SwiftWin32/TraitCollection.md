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

Creates a trait collection that consists of traits merged from a specified
array of trait collections.

``` swift
public init(traitsFrom traits: [TraitCollection]) 
```

This method takes an array of one or more trait collections and merges
them to create a new trait collection. If the array contains more than one
element, the highest-indexed element that contains a given trait is used
for that trait. For example, the following code snippet creates a trait
collection with a compact horizontal size class, because the second
element in the array overrides the first for that trait:

``` swift
let collection1: TraitCollection = TraitCollection(horizontalSizeClass: .regular)
let collection2: TraitCollection = TraitCollection(horizontalSizeClass: .compact)
let collection3: TraitCollection = TraitCollection(traitsFrom: [collection1, collection2])
```

### `init(userInterfaceIdiom:)`

Creates a trait collection that contains only a specified interface idiom.

``` swift
public init(userInterfaceIdiom: UserInterfaceIdiom) 
```

### `init(horizontalSizeClass:)`

Creates a trait collection that contains only a specified horizontal size
class.

``` swift
public init(horizontalSizeClass: UserInterfaceSizeClass) 
```

### `init(verticalSizeClass:)`

Creates a trait collection that contains only a specified vertical size
class.

``` swift
public init(verticalSizeClass: UserInterfaceSizeClass) 
```

### `init(userInterfaceStyle:)`

Creates a trait collection that contains only the specified user interface
style trait.

``` swift
public init(userInterfaceStyle: UserInterfaceStyle) 
```

### `init(accessibilityContrast:)`

Creates a trait collection that contains only the specified accessibility
contrast trait.

``` swift
public init(accessibilityContrast: AccessibilityContrast) 
```

### `init(userInterfaceLevel:)`

Creates a trait collection that contains only the specified user interface
level trait.

``` swift
public init(userInterfaceLevel: UserInterfaceLevel) 
```

### `init(legibilityWeight:)`

Creates a trait collection that contains only the specified legibility
weight trait.

``` swift
public init(legibilityWeight: LegibilityWeight) 
```

### `init(forceTouchCapability:)`

Creates a trait collection that contains only a specified force touch
capability trait.

``` swift
public init(forceTouchCapability: ForceTouchCapability) 
```

### `init(displayScale:)`

Creates a trait collection that contains only a specified display scale.

``` swift
public init(displayScale: Double) 
```

### `init(displayGamut:)`

Creates a trait collection that contains only the specified display gamut
trait.

``` swift
public init(displayGamut: DisplayGamut) 
```

### `init(layoutDirection:)`

Creates a trait collection that contains only the specified layout
direction trait.

``` swift
public init(layoutDirection: TraitEnvironmentLayoutDirection) 
```

### `init(preferredContentSizeCategory:)`

Creates a trait collection that contains only the specified content size
category trait.

``` swift
public init(preferredContentSizeCategory: ContentSizeCategory) 
```

### `init(activeAppearance:)`

Creates a trait collection that contains only the specified active
appearance trait.

``` swift
public init(activeAppearance: UserInterfaceActiveAppearance) 
```

## Properties

### `current`

The complete set of traits for the current environment.

``` swift
public private(set) static var current: TraitCollection 
```

The framework updates the value of this property before calling several
well-known methods of `View`, `ViewController`, and
`PresentationController`. The trait collection contains a complete set of
trait values describing the current environment, and does not include
unspecified or unknown values.

Changing the traits on a nonmain thread does not affect the current traits
on your applications's main thread.

### `horizontalSizeClass`

The horizontal size class of the trait collection.

``` swift
public private(set) var horizontalSizeClass: UserInterfaceSizeClass =
      .unspecified
```

### `verticalSizeClass`

The vertical size class of the trait collection.

``` swift
public private(set) var verticalSizeClass: UserInterfaceSizeClass =
      .unspecified
```

### `displayScale`

The display scale of the trait collection.

``` swift
public private(set) var displayScale: Double = 0.0
```

A value of 1.0 indicates a non-Retina display and a value of 2.0 indicates
a Retina display. The default display scale for a trait collection is 0.0
(indicating unspecified).

### `displayGamut`

The gamut of the current display.

``` swift
public private(set) var displayGamut: DisplayGamut = .unspecified
```

### `userInterfaceStyle`

The style associated with the user interface.

``` swift
public private(set) var userInterfaceStyle: UserInterfaceStyle = .unspecified
```

Use this trait to determine whether your interface should be configured
with a dark or light appearance. The default value of this trait is set to
the corresponding appearance setting on the user's device.

### `userInterfaceIdiom`

The user interface idiom of the trait collection.

``` swift
public private(set) var userInterfaceIdiom: UserInterfaceIdiom = .unspecified
```

The default user interface idiom for a trait collection is
`UserInterfaceIdiom.unspecified`.

### `userInterfaceLevel`

The elevation level of the interface.

``` swift
public private(set) var userInterfaceLevel: UserInterfaceLevel = .unspecified
```

Levels create a visual separation between different parts of your UI.
`Window` content typically appears at the `UserInterfaceLevel.base` level.
When you want parts of your UI to stand out from the underlying
background, assign the `UserInterfaceLevel.elevated` level to them. For
example, the system assigns the `UserInterfaceLevel.elevated` level to
alerts and popovers.

### `layoutDirection`

The layout direction associated with the current environment.

``` swift
public private(set) var layoutDirection: TraitEnvironmentLayoutDirection =
      .unspecified
```

Use this trait to determine whether the underlying environment uses a
left-to-right or right-to-left orientation.

### `accessibilityContrast`

The accessibility contrast associated with the current environment.

``` swift
public private(set) var accessibilityContrast: AccessibilityContrast =
      .unspecified
```

Use this trait to determine whether the user requested a high contrast
between foreground and background content. The user sets the contrast
level in Accessibility Settings.

### `legibilityWeight`

The font weight to apply to text.

``` swift
public private(set) var legibilityWeight: LegibilityWeight = .unspecified
```

The legibility weight reflects the value of the Bold Text display setting.

### `activeAppearance`

A property that indicates whether the user interface has an active
appearance.

``` swift
public private(set) var activeAppearance: UserInterfaceActiveAppearance =
      .unspecified
```

The active appearance varies according to window activation state.

### `forceTouchCapability`

The force touch capability value of the trait collection.

``` swift
public private(set) var forceTouchCapability: ForceTouchCapability =
      .unspecified
```

Force Touch is available only on certain devices. On those devices,
availability is determined by the user's associated accessibility setting
in Settings. Check this property's value on app launch, and in your
implementation of the `traitCollectionDidChange(_:)` method.

If this property does not contain a value, the meaning is equivalent to
the value `ForceTouchCapability.unknown`.

### `preferredContentSizeCategory`

The font sizing option preferred by the user.

``` swift
public private(set) var preferredContentSizeCategory: ContentSizeCategory =
      .unspecified
```

With dynamic text sizing, users can ask that apps display text using fonts
that are larger or smaller than the normal font size defined by the
system. For example, a user with a visual impairment might request a
larger default font size to make it easier to read text. Use the value of
this property to request a `Font` object that matches the user's requested
size.

### `imageConfiguration`

An image configuration object compatible with this trait collection.

``` swift
public var imageConfiguration: Image.Configuration 
```

The `Image.Configuration` object in this property contains the same traits
as the current trait collection.

## Methods

### `containsTraits(in:)`

Queries whether a trait collection contains all of another trait
collection's values.

``` swift
public func containsTraits(in trait: TraitCollection?) -> Bool 
```

Use this method to compare two standalone trait collections, or to compare
the interface environment's trait collection to a standalone trait
collection.

### `hasDifferentColorAppearance(comparedTo:)`

Queries whether changing between the specified and current trait
collections would affect color values.

``` swift
public func hasDifferentColorAppearance(comparedTo traitCollection: TraitCollection?)
      -> Bool 
```

Use this method to determine whether changing the traits of the current
environment would also change the colors in your interface. For example,
changing the `userInterfaceStyle` or `accessibilityContrast` property
usually changes the colors of your interface.

### `performAsCurrent(_:)`

Executes custom code using the traits of the current trait collection.

``` swift
public func performAsCurrent(_ actions: () -> Void) 
```

Use this method when you want to execute code using a set of traits that
differ from those in the current trait environment. For example, you might
use this method to draw part of a view's content with a different set of
traits. This method temporarily replaces the traits of the current
environment with the ones found in the current `TraitCollection`. After
the actions block finishes, the method restores the original traits to the
environment.

You can call this method from any thread of your application.
