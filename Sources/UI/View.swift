
import WinSDK

public class View {
  internal var hWnd: HWND
  internal var `class`: WindowClass
  internal var style: DWORD

  // TODO(compnerd) handle set
  public var subviews: [View] = []
  public var superview: View?
  public var frame: Rect

  public init(frame: Rect, `class`: WindowClass, style: DWORD) {
    self.class = `class`
    _ = self.class.register()
    self.style = style

    self.frame = frame
    self.hWnd =
        CreateWindowExW(0, self.class.name, "".LPCWSTR, self.style,
                        Int32(self.frame.x), Int32(self.frame.y),
                        Int32(self.frame.width), Int32(self.frame.height),
                        nil, nil, GetModuleHandleW(nil), nil)
  }

  deinit {
    _ = self.class.unregister()
  }

  public func addSubview(_ view: View) {
    if SetWindowLongPtrW(view.hWnd, GWL_STYLE, LONG_PTR(view.style | DWORD(WS_CHILD))) == 0 {
      SetWindowLongPtrW(view.hWnd, GWL_STYLE, LONG_PTR(view.style))
      return
    }

    view.style |= DWORD(WS_CHILD)
    SetParent(view.hWnd, self.hWnd)
    view.superview = self
    subviews.append(view)
  }
}
