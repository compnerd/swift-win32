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

- If you use CMake, do not forget to register `MyApplication.swift` in CMakeLists.txt.

```txt
add_executable(...
... MyApplication.swift)
```

- In `Info.plist`, define a `PrincipalClass` entry with a String value of `{AppName}.{CustomClassName}`. For example, if the application is named `CustomPrincipalClass`, then we can register `MyApplication` (defined above) as follows:

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

- You can reference your custom application subclass anywhere in you app by casting `Application.shared` to your custom application class. For example, here is how to print the `message` property of the `MyApplication` subclass defined above:

```swift
if let application = Application.shared as? MyApplication {
    print(application.message)
}
```