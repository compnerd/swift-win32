Swift/Win32 - A Swift Application Framework for Windows
-------------------------------------------------------

<p align="center">
  <img alt="Swift/Win32 Screenshot" src="Documentation/Images/screenshot.png" width="299" height="588"/>
</p>

Swift/Win32 aims to provide a [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) model for writing applications on Windows.  It provides Swift friendly wrapping of the Win32 APIs much like [MFC](https://en.wikipedia.org/wiki/Microsoft_Foundation_Class_Library) did for C++.

## Build Requirements

- Latest Swift **Development** Snapshot (2021-01-26 or later)<sup>[1](#snapshot-requirements)</sup>
- Windows SDK 10.0.107763 or newer
- CMake 3.16 or newer

<sup><a name="snapshot-requirements">1</a></sup> Stable releases are not currently supported as they are built from release branches, and this project requires the latest development snapshot from the `main` branch.<br/>

## Building

This project requires the latest Swift snapshot (January 26, 2021 or newer). You can use the the snapshot binaries from [swift.org](https://swift.org/download/) or download the nightly build from [Azure](https://dev.azure.com/compnerd/swift-build).

### Recommended (CMake)

The following example session shows how to build with CMake 3.16 or newer.

```cmd
cmake -B build -D BUILD_SHARED_LIBS=YES -D CMAKE_BUILD_TYPE=Release -D CMAKE_Swift_FLAGS="-sdk %SDKROOT%" -G Ninja -S .
ninja -C build SwiftWin32 UICatalog

%CD%\build\bin\UICatalog.exe
```

### Swift Package Manager

Building this project with swift-package-manager is supported although CMake is recommended for ease.  The Swift Package Manager based build is required for code completion via SourceKit-LSP.  It also allows for the use of Swift/Win32 in other applications using SPM.  In order to use SPM to build this project additional post-build steps are required to use the demo applications.

The following known limitations are known:

1. It is not possible to deploy auxiliary files which are required for Swift/Win32 based applications to function to the correct location.
2. It is not possible to build and run multiple demo projects as the auxiliary files collide.

```cmd
swift build --product UICatalog
mt -nologo -manifest Examples\UICatalog\UICatalog.exe.manifest -outputresource:.build\x86_64-unknwon-windows-msvc\debug\UICatalog.exe
copy Examples\UICatalog\Info.plist .build\x86_64-unknown-windows-msvc\debug\
.build\x86_64-unknown-windows-msvc\debug\UICatalog.exe
```
