# swift-win32

This is a thin wrapper over the Win32 APIs for graphics on Windows to make it
easier to write Windows applications in Swift.

This requires the latest (git) version of Swift (alternatively, you can use the
nightlies from https://dev.azure.com/compnerd/windows-swift).

```cmd
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release .
ninja -C build SwiftWin32 HelloSwift
.\build\HelloSwift
```

