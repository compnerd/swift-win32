
import WinSDK

open class WindowDelegate: DefaultDelegate {
  open override func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    if let view = self.view {
      let rc = RenderContext(hWnd)
      rc.fillBackground(color: view.backgroundColor)
    }
    return 0
  }
}

public class Window: View {
  public var title: String = "" {
    didSet(value) {
      SetWindowTextW(self.hWnd, value.LPCWSTR)
    }
  }

  private var usedDefaultClass: Bool
  public init(frame: Rect = .default, `class`: WindowClass? = nil,
              style: DWORD = WS_OVERLAPPEDWINDOW, title: String = "") {
    struct Counter {
      static var value: UInt64 = 0
    }
    self.usedDefaultClass = `class` == nil
    self.title = title
    let wnd = `class` ?? WindowClass(hInst: GetModuleHandleW(nil),
                                     name: "w\(Counter.value)")
    super.init(frame: frame, class: wnd, style: DWORD(WS_OVERLAPPEDWINDOW))
    self.title = title
    SetWindowTextW(self.hWnd, title.LPCWSTR)
    self.delegate = WindowDelegate()
    Counter.value += 1
  }

  deinit {
    if usedDefaultClass {
      _ = self.class.unregister()
    }
  }
}
