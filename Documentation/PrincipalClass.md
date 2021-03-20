## Principal Class

Defining a PrincipalClass allows to use a subclass of the `Application` class.

### How to use an Application subclass ?

- Define a class that inherits from `SwiftWin32.Application`. Here is an example:

```swift
import SwiftWin32

public class MyApplication: Application {
    let message = "This is a message from MyApplication subclass"
}
```

- In `Info.plist`, define a `PrincipalClass` entry with a String value of `{Module}.{CustomClassName}`. For example, if the product module name is `CustomPrincipalClass`, then we can register `MyApplication` (defined above) as follows:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>PrincipalClass</key>
    <string>CustomPrincipalClass.MyApplication</string>
    <!-- other content -->
  </dict>
</plist>
```
