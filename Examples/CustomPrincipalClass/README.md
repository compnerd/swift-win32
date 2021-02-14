# Custom Application class steps

- Define a class that inherits from `SwiftWin32.Application`. See [MyApplication.swift](./MyApplication) for an example.
- In [Info.plist](./info.plst), defind a `NSPrincipalClass` with a String value of `{AppName}.{CustomClassName}`. In this example, the value is `CustomPrincipalClass.MyApplication`
- You can reference the application anywhere in you app by casting `Application.shared` to your custom application class

