	
import WinSDK

public class Window: View {
  public var title: String = "" {
      didSet(value) {
          SetWindowTextW(self.hWnd, value.LPCWSTR)
      }
  }

  private var usedDefaultClass: Bool
  public init(frame: Rect = .default, `class`: WindowClass? = nil,
              style: UInt32 = WS_OVERLAPPEDWINDOW, title: String = "") {
    struct Counter {
      static var value: UInt64 = 0
    }
    self.usedDefaultClass = `class` == nil
    self.title = title
    let wnd = `class` ?? WindowClass(hInst: GetModuleHandleW(nil),
                                     name: "w\(Counter.value)")
    super.init(frame: frame, class: wnd, style: Int32(WS_OVERLAPPEDWINDOW))
    self.title = title
    SetWindowTextW(self.hWnd, title.LPCWSTR)
    Counter.value += 1
  }

  deinit {
    if usedDefaultClass {
      _ = self.class.unregister()
    }
  }
}
