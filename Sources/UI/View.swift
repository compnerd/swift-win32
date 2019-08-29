
import WinSDK


typealias WindowProc = @convention(c) (HWND, UINT, WPARAM, LPARAM) -> LRESULT
let WndProc: WindowProc = { (hWnd, uMsg, wParam, lParam) in
  let pointer = GetWindowLongPtrW(hWnd, GWLP_USERDATA)
  if pointer == 0 { return DefWindowProcW(hWnd, uMsg, wParam, lParam) }

  let delegate: ViewDelegate =
      unsafeBitCast(pointer, to: AnyObject.self) as! ViewDelegate 
  switch uMsg {
  case UINT(WM_CREATE):
    return delegate.OnCreate(hWnd, wParam, lParam)
  case UINT(WM_DESTROY):
    return delegate.OnDestroy(hWnd, wParam, lParam)
  case UINT(WM_PAINT):
    return delegate.OnPaint(hWnd, wParam, lParam)
  case UINT(WM_QUIT):
    return delegate.OnQuit(hWnd, wParam, lParam)
  case UINT(WM_LBUTTONDOWN):
    return delegate.OnLeftButtonDown(hWnd, wParam, lParam)
  default:
    return DefWindowProcW(hWnd, uMsg, wParam, lParam)
  }
}

extension Rect {
  public static let `default`: Rect = Rect(x:      Double(CW_USEDEFAULT),
                                           y:      Double(CW_USEDEFAULT),
                                           width:  Double(CW_USEDEFAULT),
                                           height: Double(CW_USEDEFAULT))
}

open class View {
  public private(set) var subviews = [View]()
  public private(set) var superview: View? = nil
  public private(set) var frame: Rect
  
  public var delegate: ViewDelegate {
    willSet(value) {
      SetWindowLongPtrW(self.hWnd, GWLP_USERDATA,
                        unsafeBitCast(value as AnyObject, to: LONG_PTR.self))
      value.view = self
    }
  }

  public var backgroundColor: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) {
    didSet(value) {
        self.invalidate()
    }
  }

  internal var hWnd: HWND
  internal var `class`: WindowClass
  internal var style: Int32
  
  public init(frame: Rect = .default, `class`: WindowClass, style: Int32 = 0) {
    self.frame = frame
    self.class = `class`
    _ = self.class.register()
    self.style = style
    self.hWnd = CreateWindowExW(0, self.class.name, "".LPCWSTR,
                                DWORD(self.style),
                                Int32(self.frame.x), Int32(self.frame.y),
                                Int32(self.frame.width), Int32(self.frame.height),
                                nil, nil, GetModuleHandleW(nil), nil)
    self.delegate = DefaultDelegate()
    SetWindowLongPtrW(self.hWnd, GWLP_USERDATA,
                      unsafeBitCast(self.delegate as AnyObject, to: LONG_PTR.self))
    SetWindowLongPtrW(hWnd, GWLP_WNDPROC,
                      unsafeBitCast(WndProc, to: LONG_PTR.self))
  }

  public func addSubview(_ view: View) {
    view.superview = self
    view.style |= WS_CHILD
    SetWindowLongPtrW(view.hWnd, GWL_STYLE, LONG_PTR(view.style))
    SetParent(view.hWnd, self.hWnd)
    subviews.append(view)
  }

  public func addSubviews(_ views: [View]) {
    for v in views {
      addSubview(v)
    }
  }

  public func invalidate() {
      RedrawWindow(self.hWnd, nil, nil, UINT(RDW_INVALIDATE))
  }

  public func show() {
    ShowWindow(self.hWnd, SW_SHOW)
  }
}

public extension View {
  var _handle: HWND? {
    return hWnd
  }
}
