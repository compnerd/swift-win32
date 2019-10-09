
import WinSDK

public typealias WindowProc =
    @convention(c) (HWND?, UINT, WPARAM, LPARAM) -> LRESULT

public class WindowClass {
  internal var name: [WCHAR]

  internal var hInstance: HINSTANCE?
  internal var value: WNDCLASSEXW?
  internal var atom: ATOM?

  public init(hInst hInstance: HINSTANCE, name: String,
              WindowProc lpfnWindowProc: WindowProc? = DefWindowProcW) {
    self.name = name.LPCWSTR

    self.hInstance = hInstance
    self.value = WNDCLASSEXW(cbSize: UINT(MemoryLayout<WNDCLASSEXW>.size),
                             style: 0,
                             lpfnWndProc: lpfnWindowProc,
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

  public init(named: String) {
    self.name = named.LPCWSTR
  }

  public func register() -> Bool {
    guard value != nil, atom == nil else { return true }
    self.atom = RegisterClassExW(&value!)
    return self.atom != nil
  }

  public func unregister() -> Bool {
    guard value != nil, atom != nil else { return false }
    if UnregisterClassW(self.name, self.hInstance) {
      self.atom = nil
    }
    return self.atom == nil
  }
}
