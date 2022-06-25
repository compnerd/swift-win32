---
layout: default
title: PickerViewDataSource
parent: SwiftWin32
---
# PickerViewDataSource

Mediates between a `PickerView` object and your application's data model for
that picker view.

``` swift
public protocol PickerViewDataSource: AnyObject 
```

## Inheritance

`AnyObject`

## Requirements

### numberOfComponents(in:​)

Called by the picker view when it needs the number of components.

``` swift
func numberOfComponents(in pickerView: PickerView) -> Int
```

### pickerView(\_:​numberOfRowsInComponent:​)

Called by the picker view when it needs the number of rows for a specified
component.

``` swift
func pickerView(_ pickerView: PickerView,
                  numberOfRowsInComponent component: Int) -> Int
```
