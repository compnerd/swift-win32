
public protocol ApplicationDelegate: class {
  @available(*, deprecated)
  func applicationDidFinishLaunching(_: Application) -> Bool

  func application(_ application: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool
}

public extension ApplicationDelegate {
  func applicationDidFinishLaunching(_: Application) -> Bool {
    return true
  }

  func application(_ application: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool {
    return true
  }
}

