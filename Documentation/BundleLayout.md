## Bundle Layout

### What Files Go Into an Application Bundle?

The following table summarises the types of files that need to be included in an application distribution.

| File | Description |
| ---- | ----------- |
| Info.plist | **(Optional)** The *information property list* file is a structured file that contains configuration information for the application. |
| Executable | The application's main entry point and any statically linked code. |
| Libraries | Any additional dependent libraries needed by the main executable. |
| Application Manifest | The Windows application manifest which is used to enable features for modern Windows APIs. |
| Swift Runtime | **(Optional)** The runtime libraries for the Swift runtime. |

### Anatomy of a Windows Application Bundle

#### The Windows Application Bundle Structure

The Windows application bundle contains the application executable and any resources required for the application.  The following listing shows the structure of a simple application called `Application`.

```
Application.app
    Application.exe
    Application.exe.manifest
    Resources
        Image.png
```

| File | Description |
| ---- | ----------- |
| Application.exe | (Required) The executable file containing the application code. |
| Application.exe.manifest | (Required) The executable manifest.  This must be named the same as the executable with an additional `.manifest` suffix. |
| Info.plist | (Recommended) The file contains confituration information for the application. |
| Custom resource files | Any additional resources, including but not limited to images, sound files, and custom data files needed for the application. |

### The Information Property List File

Applications should provide an information property list (`Info.plist`) file
containing the application's configuration information.  If one is not provided,
the framework wil attempt to subsitute defaults.  The following table lists some
of the keys which are commonly used.  Although the file nor the keys are
required, they provide a way to adjust the configuration of the application at
launch time.  Providing the configuration helps ensure te proper presentation of
the application to the user.

| Key | Description |
| --- | ----------- |
| `PrincipalClass` (Principal class) | The entry point for for the application.  This is either the default `Application` or a subclass. |
