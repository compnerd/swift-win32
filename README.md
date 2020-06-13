# Swift/Win32

This is a thin wrapper over the Win32 APIs for graphics on Windows to make it
easier to write Windows applications in Swift.

This requires the 5.2 or newer. You can use the the release binaries from
[//swift/build](https://github.com/compnerd/swift-build) or download the nightly
build from [Azure](https://dev.azure.com/compnerd/swift-build).

```cmd
set SDKROOT=%SystemDrive%/Library/Developer/Platforms/Windows.platform/Developer/SDKs/Windows.sdk
set SWIFTFLAGS=-sdk %SDKROOT% -I %SDKROOT%/usr/lib/swift -L %SDKROOT%/usr/lib/swift/windows

cmake -B build -D BUILD_SHARED_LIBS=YES -D CMAKE_BUILD_TYPE=Release -D CMAKE_Swift_FLAGS="%SWIFTFLAGS%" -G Ninja -S .
ninja -C build SwiftWin32 HelloSwift

%CD%\build\bin\HelloSwift
```

