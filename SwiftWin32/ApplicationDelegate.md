---
layout: default
title: ApplicationDelegate
parent: SwiftWin32
---
# ApplicationDelegate

A set of methods used to manage shared behaviours for the application.

``` swift
public protocol ApplicationDelegate: AnyObject, _TriviallyConstructible 
```

## Inheritance

`AnyObject`, [`_TriviallyConstructible`](https://compnerd.github.io/swift-win32/SwiftWin32/_TriviallyConstructible)

## Default Implementations

### `application(_:willFinishLaunchingWithOptions:)`

``` swift
public func application(_ application: Application,
                          willFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool 
```

### `application(_:didFinishLaunchingWithOptions:)`

``` swift
public func application(_ application: Application,
                          didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool 
```

### `didFinishLaunchingNotification`

A notification that posts immediately after the app finishes launching.

``` swift
public static var didFinishLaunchingNotification: NSNotification.Name 
```

### `applicationDidBecomeActive(_:)`

``` swift
public func applicationDidBecomeActive(_: Application) 
```

### `applicationWillResignActive(_:)`

``` swift
public func applicationWillResignActive(_: Application) 
```

### `applicationDidEnterBackground(_:)`

``` swift
public func applicationDidEnterBackground(_: Application) 
```

### `applicationWillEnterForeground(_:)`

``` swift
public func applicationWillEnterForeground(_: Application) 
```

### `applicationWillTerminate(_:)`

``` swift
public func applicationWillTerminate(_: Application) 
```

### `didBecomeActiveNotification`

A notification that posts when the app becomes active.

``` swift
public static var didBecomeActiveNotification: NSNotification.Name 
```

### `willResignActiveNotification`

A notification that posts when the app is no longer active and loses
focus.

``` swift
public static var willResignActiveNotification: NSNotification.Name 
```

### `didEnterBackgroundNotification`

A notification that posts when the app enters the background.

``` swift
public static var didEnterBackgroundNotification: NSNotification.Name 
```

### `willEnterForegroundNotification`

A notification that posts shortly before an app leaves the background
state on its way to becoming the active app.

``` swift
public static var willEnterForegroundNotification: NSNotification.Name 
```

### `willTerminateNotification`

A notification that posts when the app is about to terminate.

``` swift
public static var willTerminateNotification: NSNotification.Name 
```

### `applicationProtectedDataDidBecomeAvailable(_:)`

``` swift
public func applicationProtectedDataDidBecomeAvailable(_ application: Application) 
```

### `applicationProtectedDataWillBecomeUnavailable(_:)`

``` swift
public func applicationProtectedDataWillBecomeUnavailable(_ application: Application) 
```

### `applicationDidReceiveMemoryWarning(_:)`

``` swift
public func applicationDidReceiveMemoryWarning(_ application: Application) 
```

### `applicationSignificantTimeChange(_:)`

``` swift
public func applicationSignificantTimeChange(_ application: Application) 
```

### `protectedDataDidBecomeAvailableNotification`

A notification that posts when the protected files become available for
your code to access.

``` swift
public static var protectedDataDidBecomeAvailableNotification: NSNotification.Name 
```

### `protectedDataWillBecomeUnavailableNotification`

A notification that posts shortly before protected files are locked down
and become inaccessible.

``` swift
public static var protectedDataWillBecomeUnavailableNotification: NSNotification.Name 
```

### `didReceiveMemoryWarningNotification`

A notification that posts when the app receives a warning from the
operating system about low memory availability.

``` swift
public static var didReceiveMemoryWarningNotification: NSNotification.Name 
```

### `significantTimeChangeNotification`

A notification that posts when there is a significant change in time, for
example, change to a new day (midnight), carrier time update, and change
to or from daylight savings time.

``` swift
public static var significantTimeChangeNotification: NSNotification.Name 
```

### `application(_:configurationForConnecting:options:)`

``` swift
public func application(_ application: Application,
                          configurationForConnecting connectingSceneSession: SceneSession,
                          options: Scene.ConnectionOptions) -> SceneConfiguration 
```

### `application(_:didDiscardSceneSessions:)`

``` swift
public func application(_ application: Application,
                          didDiscardSceneSessions sceneSessions: Set<SceneSession>) 
```

### `main()`

``` swift
public static func main() 
```

## Requirements

### application(\_:​willFinishLaunchingWithOptions:​)

Informs the delegate that the application launch process has begun.

``` swift
func application(_ application: Application,
                   willFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool
```

### application(\_:​didFinishLaunchingWithOptions:​)

Informs the delegate that the application launch process has ended and
the application is almost ready to run.

``` swift
func application(_ application: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool
```

### applicationDidBecomeActive(\_:​)

Informs the delegate that the application has become active.

``` swift
func applicationDidBecomeActive(_ application: Application)
```

### applicationWillResignActive(\_:​)

Informs the delegate that the application is about to become inactive.

``` swift
func applicationWillResignActive(_ application: Application)
```

### applicationDidEnterBackground(\_:​)

Informs the delegate that the application is now in the background.

``` swift
func applicationDidEnterBackground(_ application: Application)
```

### applicationWillEnterForeground(\_:​)

Informs the delegate that the application is about to enter the foreground.

``` swift
func applicationWillEnterForeground(_ application: Application)
```

### applicationWillTerminate(\_:​)

Informs the delegate that the application is about to terminate.

``` swift
func applicationWillTerminate(_ application: Application)
```

### applicationProtectedDataDidBecomeAvailable(\_:​)

Tells the delegate that protected files are available now.

``` swift
func applicationProtectedDataDidBecomeAvailable(_ application: Application)
```

### applicationProtectedDataWillBecomeUnavailable(\_:​)

Tells the delegate that the protected files are about to become
unavailable.

``` swift
func applicationProtectedDataWillBecomeUnavailable(_ application: Application)
```

### applicationDidReceiveMemoryWarning(\_:​)

Tells the delegate when the app receives a memory warning from the system.

``` swift
func applicationDidReceiveMemoryWarning(_ application: Application)
```

### applicationSignificantTimeChange(\_:​)

Tells the delegate when there is a significant change in the time.

``` swift
func applicationSignificantTimeChange(_ application: Application)
```

### application(\_:​configurationForConnecting:​options:​)

Returns the configuration data to use when creating a new scene.

``` swift
func application(_ application: Application,
                   configurationForConnecting connectingSceneSession: SceneSession,
                   options: Scene.ConnectionOptions) -> SceneConfiguration
```

### application(\_:​didDiscardSceneSessions:​)

Informs the delegate that the user closed one or more of the application's
scenes.

``` swift
func application(_ application: Application,
                   didDiscardSceneSessions sceneSessions: Set<SceneSession>)
```
