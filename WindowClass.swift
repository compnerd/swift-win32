
import WinSDK

public class WindowClass {
  internal var `class`: WNDCLASSEXW
  internal var name: UnsafeMutableBufferPointer<WCHAR>

  public init(hInst hInstance: HINSTANCE, name: String) {
    let duplicate = name.withCString(encodedAs: UTF16.self) { return _wcsdup($0) }
    self.name = UnsafeMutableBufferPointer<WCHAR>(start: duplicate,
                                                  count: name.utf16.count)

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
                             lpszClassName: self.name.baseAddress,
                             hIconSm: nil)
  }

  deinit {
    name.deallocate()
  }

  public func register() -> Bool {
    return RegisterClassExW(&self.class) != 0
  }
}

