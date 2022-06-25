---
layout: default
title: PickerViewDelegate
parent: SwiftWin32
---
# PickerViewDelegate

The delegate of a `PickerView` object must adopt this protocol and implement
at least some of its methods to provide the picker view with the data it
needs to construct itself.

``` swift
public protocol PickerViewDelegate: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `pickerView(_:rowHeightForComponent:)`

``` swift
public func pickerView(_ pickerView: PickerView,
                         rowHeightForComponent component: Int) -> Double 
```

### `pickerView(_:widthForComponent:)`

``` swift
public func pickerView(_ pickerView: PickerView,
                         widthForComponent component: Int) -> Double 
```

### `pickerView(_:titleForRow:forComponent:)`

``` swift
public func pickerView(_ pickerView: PickerView, titleForRow row: Int,
                         forComponent component: Int) -> String? 
```

### `pickerView(_:attributedTitleForRow:forComponent:)`

``` swift
public func pickerView(_ pickerView: PickerView,
                         attributedTitleForRow row: Int,
                         forComponent component: Int) -> NSAttributedString? 
```

### `pickerView(_:viewForRow:forComponent:reusing:)`

``` swift
public func pickerView(_ pickerView: PickerView, viewForRow row: Int,
                         forComponent component: Int, reusing view: View?)
      -> View 
```

### `pickerView(_:didSelectRow:inComponent:)`

``` swift
public func pickerView(_ pickerView: PickerView, didSelectRow row: Int,
                         inComponent component: Int) 
```

## Requirements

### pickerView(\_:​rowHeightForComponent:​)

Called by the picker view when it needs the row height to use for drawing
row content.

``` swift
func pickerView(_ pickerView: PickerView,
                  rowHeightForComponent component: Int) -> Double
```

### pickerView(\_:​widthForComponent:​)

Called by the picker view when it needs the row width to use for drawing
row content.

``` swift
func pickerView(_ pickerView: PickerView,
                  widthForComponent component: Int) -> Double
```

### pickerView(\_:​titleForRow:​forComponent:​)

Called by the picker view when it needs the title to use for a given row
in a given component.

``` swift
func pickerView(_ pickerView: PickerView, titleForRow row: Int,
                  forComponent component: Int) -> String?
```

### pickerView(\_:​attributedTitleForRow:​forComponent:​)

Called by the picker view when it needs the styled title to use for a
given row in a given component.

``` swift
func pickerView(_ pickerView: PickerView, attributedTitleForRow row: Int,
                  forComponent component: Int) -> NSAttributedString?
```

### pickerView(\_:​viewForRow:​forComponent:​reusing:​)

Called by the picker view when it needs the view to use for a given row in
a given component.

``` swift
func pickerView(_ pickerView: PickerView, viewForRow row: Int,
                  forComponent component: Int, reusing view: View?) -> View
```

### pickerView(\_:​didSelectRow:​inComponent:​)

Called by the picker view when the user selects a row in a component.

``` swift
func pickerView(_ pickerView: PickerView, didSelectRow row: Int,
                  inComponent component: Int)
```
