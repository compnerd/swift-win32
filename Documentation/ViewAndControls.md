## Views and controls

Swift-Win32 provides visual components such as labels and buttons.

![View and controls](./Images/views-and-controls.png)

The visual component library API is inspired by [UIKit](https://developer.apple.com/documentation/uikit/views_and_controls) but their actual implementation is provided by [win32 windows controls](https://docs.microsoft.com/en-us/windows/win32/controls/common-control-window-classes). For example: the `Label` has a similar API than UIKit's `UILabel` and is drawn using the `WC_STATIC` win32 control called.

The root class for all views is the `View` class. Some views which are designed for user interactions (such as button) inherit from the `Control` class (which in turn inherits the `View` class).

### Views and controls catalog

| Control | win32 control | Description |
| ---- | -- | ----------- |
| Label | WC_STATIC | A view that displays text |
| Button | WC_BUTTON |A control that executes code in response to clicks |
| TextView | | A view that shows scrollable lines of text |
| Slider | | A control that  |
| ImageView |  |  |
