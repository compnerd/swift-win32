Swift/Win32 - A Swift Application Framework for Windows
-------------------------------------------------------

<p align="center">
  <img alt="Swift/Win32 Screenshot" src="Documentation/Images/screenshot.png" width="299" height="588"/>
</p>

Swift/Win32 aims to provide a [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) model for writing applications on Windows.  It provides Swift friendly wrapping of the Win32 APIs much like [MFC](https://en.wikipedia.org/wiki/Microsoft_Foundation_Class_Library) did for C++.

## Build Requirements

- Swift 5.4 or newer
- Windows SDK 10.0.107763 or newer
- CMake 3.16 or newer

## Building

This project requires Swift 5.4 or newer. You can use the the snapshot binaries from [swift.org](https://swift.org/download/), download the nightly build from [Azure](https://dev.azure.com/compnerd/swift-build), or build the Swift compiler from source.

### Recommended (CMake)

The following example session shows how to build with CMake 3.16 or newer.

```cmd
cmake -B build -D BUILD_SHARED_LIBS=YES -D CMAKE_BUILD_TYPE=Release -D CMAKE_Swift_FLAGS="-sdk %SDKROOT%" -G Ninja -S .
ninja -C build SwiftWin32 UICatalog

%CD%\build\bin\UICatalog.exe
```

<details>
  <summary>Required Environment Variables</summary>

  The CMake build will automatically perform the application manifest merging via the `mt` tool, which is part of the Visual Studio build tools.  Ensure that you run the build under the `x64 Native Tools Command Prompt for VS2019` (or the appropriate shell for the version of Visual Studio).

  The Swift installer will also add environment variables, ensure that you have restarted the terminal emulator after installing the toolchain to pick up the required environment variables.
</details>

### Swift Package Manager

Building this project with swift-package-manager is supported although CMake is recommended for ease.  The Swift Package Manager based build is required for code completion via SourceKit-LSP.  It also allows for the use of Swift/Win32 in other applications using SPM.  In order to use SPM to build this project additional post-build steps are required to use the demo applications.

The following known limitations are known:

1. It is not possible to deploy auxiliary files which are required for Swift/Win32 based applications to function to the correct location.
2. It is not possible to build and run multiple demo projects as the auxiliary files collide.

```cmd
swift build --product UICatalog
mt -nologo -manifest Examples\UICatalog\UICatalog.exe.manifest -outputresource:.build\x86_64-unknown-windows-msvc\debug\UICatalog.exe
copy Examples\UICatalog\Info.plist .build\x86_64-unknown-windows-msvc\debug\
.build\x86_64-unknown-windows-msvc\debug\UICatalog.exe
```

In order to get access to the manifest tool (`mt`), the build and testing should occur in a [x64 Native Tools Command Prompt for VS2019](https://docs.microsoft.com/en-us/cpp/build/how-to-enable-a-64-bit-visual-cpp-toolset-on-the-command-line?view=msvc-160)

## Testing

The current implementation is still under flux and many of the interfaces we expect to be present are not yet implemented.  Because clearly indicating the missing surface makes it easier to focus on what needs to be accomplished, there are many instances of interfaces being declared but not implemented.  Most of these sites will abort if they are reached.  In order to enable testing for scenarios which may interct with these cases, a special condition has been added as `ENABLE_TESTING` to allow us to bypass the missing functionality.

You can run tests by adding that as a flag when invoking the SPM test command as:

```cmd
swift test -Xswiftc -DENABLE_TESTING
```
