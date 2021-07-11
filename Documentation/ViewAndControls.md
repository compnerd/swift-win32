## Views and controls

Swift-Win32 provides visual components such as labels and buttons.

![View and controls](./Images/views-and-controls.png)

The visual component library API is inspired by [UIKit](https://developer.apple.com/documentation/uikit/views_and_controls).
For example, the `Label` class of Swift-Win32 has a `text` property similarly to UIKIt's `UILabel`.

The root class for all views is the `View` class.
Some views which are designed for user interactions, such as the `Button` class, inherit from the `Control` class (which in turn inherits the `View` class).

### Views and controls catalog

| View or control | Description                                              |
| --------------- | -------------------------------------------------------- |
| Label           | A view that displays text                                |
| TextView        | A view that shows scrollable lines of text               |
| ImageView       | A view that display and image                            |
| ProgressView    | A view that renders a progress bar                       |
| Button          | A control that executes code in response to clicks       |
| DatePicker      | A control that lets the user choose a date               |
| TableView       | A view that shows a list of items                        |
| TextField       | A control that lets the user enter text                  |
| Slider          | A control that permits to selects a value in a range     |
| Stepper         | A control that allows to increment and decrement a value |
| Swicth          | A control that offers two choices                        |

### How views and controls are implemented

The actual implementation is provided by the [Windows Common Controls](https://docs.microsoft.com/en-us/windows/win32/controls/common-control-window-classes) of the win32 API.
For example: the `Label` view is drawn using the `WC_STATIC` Windows window control.
