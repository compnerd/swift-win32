# Swift/Win32

This is a thin wrapper over the Win32 APIs for graphics on Windows to make it
easier to write Windows applications in Swift.

This requires the 5.2 or newer. You can use the the release binaries from
[//swift/build](https://github.com/compnerd/swift-build) or download the nightly
build from [Azure](https://dev.azure.com/compnerd/swift-build).

```cmd
cmake -B build -D BUILD_SHARED_LIBS=YES -D CMAKE_BUILD_TYPE=Release -G Ninja  -S .
ninja -C build SwiftWin32 HelloSwift
%CD%\build\bin\HelloSwift
```

