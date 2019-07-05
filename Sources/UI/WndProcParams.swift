
import WinSDK

public struct OnCreateParams {
  public let wParam: WPARAM
  public let lParam: LPARAM

  public init(_ wParam: WPARAM, _ lParam: LPARAM) {
    self.wParam = wParam
    self.lParam = lParam
  }

  public var createStruct: CREATESTRUCTA {
    let ptr = UnsafePointer<CREATESTRUCTA>(bitPattern: Int(self.lParam))
    return ptr?.pointee ?? CREATESTRUCTA()
  }
}

public struct OnCloseParams {
  public let wParam: WPARAM
  public let lParam: LPARAM
  // wParam and lParam are unused  
  public init(_ wParam: WPARAM, _ lParam: LPARAM) {
    self.wParam = wParam
    self.lParam = lParam
  }
}

public struct OnDestroyParams {
  public let wParam: WPARAM
  public let lParam: LPARAM
  // wParam and lParam are unused  

  public init(_ wParam: WPARAM, _ lParam: LPARAM) {
    self.wParam = wParam
    self.lParam = lParam
  }
}

public struct OnPaintParams {
  public let wParam: WPARAM
  public let lParam: LPARAM
  // wParam and lParam are unused for OnPaint

  public init(_ wParam: WPARAM, _ lParam: LPARAM) {
    self.wParam = wParam
    self.lParam = lParam
  }
}

public struct OnQuitParams {
  public let wParam: WPARAM
  public let lParam: LPARAM

  public init(_ wParam: WPARAM, _ lParam: LPARAM) {
    self.wParam = wParam
    self.lParam = lParam
  }

  public var exitCode: Int {
    return Int(self.wParam)
  }
}

public struct OnLButtonDownParams {
  public let wParam: WPARAM
  public let lParam: LPARAM

  public init(_ wParam: WPARAM, _ lParam: LPARAM) {
    self.wParam = wParam
    self.lParam = lParam
  }
  
  public var controlDown: Bool {
      return (self.wParam & UInt64(MK_CONTROL)) != 0
  }

  public var lButtonDown: Bool {
    return (self.wParam & UInt64(MK_LBUTTON)) != 0
  }

  public var middleButtonDown: Bool {
    return (self.wParam & UInt64(MK_MBUTTON)) != 0
  }

  public var rightButtonDown: Bool {
    return (self.wParam & UInt64(MK_RBUTTON)) != 0
  }
    
  public var shiftDown: Bool {
    return (self.wParam & UInt64(MK_SHIFT)) != 0
  }
    
  public var xButton1Down: Bool {
    return (self.wParam & UInt64(MK_XBUTTON1)) != 0
  }
    
  public var xButton2: Bool {
    return (self.wParam & UInt64(MK_XBUTTON2)) != 0
  }

  public var x: UInt16 {
    return UInt16((UInt32(self.lParam) >> 0) & 0xFFFF)
  }

  public var y: UInt16 {
    return UInt16((UInt32(self.lParam) >> 16) & 0xFFFF)
  }

  public var pos: Point {
    return Point(x: Double(self.x), y: Double(self.y))
  }
}
