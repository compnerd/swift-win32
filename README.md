Swift/Win32 - A Swift Application Framework for Windows
-------------------------------------------------------

<p align="center">
  <img alt="Swift/Win32 Screenshot" src="screenshot.png"/>
</p>

Swift/Win32 aims to provide a [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) model for writing applications on Windows.  It provides Swift friendly wrapping of the Win32 APIs much like [MFC](https://en.wikipedia.org/wiki/Microsoft_Foundation_Class_Library) did for C++.

## Build Requirements

- Latest Swift Snapshot (10/24 or later)
- Windows SDK 10.0.107763 or newer
- CMake 3.16 or newer

## Building

This project requires the latest Swift snapshot (October 24, 2020 or newer). You can use the the snapshot binaries from [swift.org](https://swift.org/download/) or download the nightly build from [Azure](https://dev.azure.com/compnerd/swift-build).

### Recommended (CMake)

The following example session shows how to build with CMake 3.16 or newer.

```cmd
cmake -B build -D BUILD_SHARED_LIBS=YES -D CMAKE_BUILD_TYPE=Release -D CMAKE_Swift_FLAGS="-sdk %SDKROOT%" -G Ninja -S .
ninja -C build SwiftWin32 UICatalog

%CD%\build\bin\UICatalog.exe
```

### Experimental (Swift Package Manager)

Building this project with swift-package-manager is experimental and does not fully function.  In particular, it is not possible to deploy auxiliary files which are required for Swift/Win32 based applications to function to the correct location.  However, the swift-package-manager build can be used with additional manual steps.  This also enables the use of VSCode and SourceKit-LSP to develop Swift/Win32 as well as applications using this library.

LLD is the recommended linker to use when using swift-package-manager.

```cmd
swift build -Xswiftc -use-ld=lld --target UICatalog
copy Examples\UICatalog\UICatalog.exe.manifest .build\x86_64-unknown-windows-msvc\debug\
copy Examples\UICatalog\Info.plist .build\x86_64-unknown-windows-msvc\debug\
.build\x86_64-unknown-windows-msvc\debug\UICatalog.exe
```
