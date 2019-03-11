
import WinSDK

public class WindowClass {
  internal var `class`: WNDCLASSEXW
  internal var name: [WCHAR]

  public init(hInst hInstance: HINSTANCE, name: String) {
    self.name = name.LPCWSTR

    self.class = WNDCLASSEXW(cbSize: UINT(MemoryLayout<WNDCLASSEXW>.size),
                             style: 0,
                             lpfnWndProc: DefWindowProcW,
                             cbClsExtra: 0,
                             cbWndExtra: 0,
                             hInstance: hInstance,
                             hIcon: nil,
                             hCursor: nil,
                             hbrBackground: nil,
                             lpszMenuName: nil,
                             lpszClassName: self.name,
                             hIconSm: nil)
  }

  public func register() -> Bool {
    return RegisterClassExW(&self.class) != 0
  }
}

