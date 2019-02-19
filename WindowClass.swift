
import WinSDK

public class WindowClass {
  public private(set) var wcClass: WNDCLASSEXW
  public private(set) var wszClassName: UnsafeMutableBufferPointer<WCHAR>

  public init(hInst hInstance: HINSTANCE, name: String) {
    let duplicate = name.withCString(encodedAs: UTF16.self) { return _wcsdup($0) }
    self.wszClassName =
        UnsafeMutableBufferPointer<WCHAR>(start: duplicate, count: name.utf16.count)

    self.wcClass = WNDCLASSEXW(cbSize: UINT(MemoryLayout<WNDCLASSEXW>.size),
                               style: 0,
                               lpfnWndProc: DefWindowProcW,
                               cbClsExtra: 0,
                               cbWndExtra: 0,
                               hInstance: hInstance,
                               hIcon: nil,
                               hCursor: nil,
                               hbrBackground: nil,
                               lpszMenuName: nil,
                               lpszClassName: wszClassName.baseAddress,
                               hIconSm: nil)
  }

  deinit {
    wszClassName.deallocate()
  }

  public func register() -> Bool {
    if RegisterClassExW(&wcClass) == FALSE {
      print("RegisterClassExW: \(GetLastError())")
      return false
    }
    return true
  }

  public func name() -> String {
    return String(decodingCString: wszClassName.baseAddress!, as: UTF16.self)
  }
}

