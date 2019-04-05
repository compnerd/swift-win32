
import WinSDK

@discardableResult
public func ApplicationMain(_ argc: Int32,
                            _ argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>,
                            _ application: Application?,
                            _ delegate: ApplicationDelegate?) -> Int32 {
  if let application = application {
    Application.shared = application
  }
  Application.shared.delegate = delegate

  if Application.shared.delegate?
        .application(Application.shared,
                     didFinishLaunchingWithOptions: nil) == false {
    return EXIT_FAILURE
  }

  var msg: MSG = MSG()
  while GetMessageW(&msg, nil, 0, 0) != FALSE {
    TranslateMessage(&msg)
    DispatchMessageW(&msg)
  }

  return EXIT_SUCCESS
}

