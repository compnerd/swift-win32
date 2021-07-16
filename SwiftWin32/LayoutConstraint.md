---
layout: default
title: LayoutConstraint
parent: SwiftWin32
---
# LayoutConstraint

``` swift
public class LayoutConstraint 
```

## Initializers

### `init(item:attribute:relatedBy:toItem:attribute:multiplier:constant:)`

Creates a constraint that defines the relationship between the specified
attributes of the given views.

``` swift
public /*convenience*/ init(item firstItem: AnyObject,
                              attribute firstAttribute: LayoutConstraint.Attribute,
                              relatedBy relation: LayoutConstraint.Relation,
                              toItem secondItem: AnyObject?,
                              attribute secondAttribute: LayoutConstraint.Attribute,
                              multiplier: Double, constant: Double) 
```

## Properties

### `isActive`

The active state of the constraint.

``` swift
public var isActive: Bool = false 
```

### `firstItem`

The first object participating in the constraint.

``` swift
public unowned(unsafe) var firstItem: AnyObject? 
```

### `firstAttribute`

The attribute of the first object participating in the constraint.

``` swift
public var firstAttribute: LayoutConstraint.Attribute 
```

### `relation`

The relationship between the two attributes in the constraint.

``` swift
public private(set) var relation: LayoutConstraint.Relation
```

### `secondItem`

The second object participating in the constraint.

``` swift
public unowned(unsafe) var secondItem: AnyObject? 
```

### `secondAttribute`

The attribute of the second object participating in the constraint.

``` swift
public var secondAttribute: LayoutConstraint.Attribute 
```

### `multiplier`

The multiplier applied to the second attribute participating in the
constraint.

``` swift
public private(set) var multiplier: Double
```

### `constant`

The constant added to the multiplied second attribute participating in the
constraint.

``` swift
public private(set) var constant: Double
```

### `firstAnchor`

The first anchor that defines the constraint.

``` swift
public private(set) var firstAnchor: LayoutAnchor<AnyObject>
```

### `secondAnchor`

The second anchor that defines the constraint.

``` swift
public private(set) var secondAnchor: LayoutAnchor<AnyObject>?
```

### `priority`

The priority of the constraint.

``` swift
public var priority: LayoutPriority = .required
```

### `identifier`

The name that identifies the constraint.

``` swift
public var identifier: String?
```

## Methods

### `activate(_:)`

Activates each constraint in the specified array.

``` swift
public class func activate(_ constraints: [LayoutConstraint]) 
```

### `deactivate(_:)`

Deactivates each constraint in the specified array.

``` swift
public class func deactivate(_ constraints: [LayoutConstraint]) 
```
