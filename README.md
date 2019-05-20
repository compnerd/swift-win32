# swift-win32

This is a thin wrapper over the Win32 APIs for graphics on Windows to make it
easier to write Windows applications in Swift.

This requires the latest (git) version of Swift (alternatively, you can use the
nightlies from https://dev.azure.com/compnerd/windows-swift).  Additionally, you
need the latest (git) version of CMake (from http://github.com/KitWare/cmake).

Assuming you are building in `S:`, you can build with:

```cmd
cmake -G Ninja S:/swift-win32
ninja SwiftWin32
ninja HelloSwift
.\HelloSwift
```

