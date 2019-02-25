# swift-win32

This is a thin wrapper over the Win32 APIs for graphics on Windows to make it
easier to write Windows applications in Swift.

This requires the latest (git) version of Swift (alternatively, you can use the
nightlies from https://dev.azure.com/compnerd/windows-swift).  Additionally, you
need the latest (git) version of CMake (from http://github.com/KitWare/cmake)
and you need the new language support from
https://github.com/compnerd/cmake-swift.

Assuming you are building in `S:`, you can build with:

```cmd
cmake -G Ninja -DCMAKE_MODULES_PATH=S:/cmake-swift/Modules -DCMAKE_Swift_COMPILER=C:/Library/Developer/Toolchains/unknown-Asserts-development.xctoolchain/usr/bin/swiftc.exe S:/swift-win32
ninja SwiftWin32
ninja HelloSwift
.\HelloSwift
```

