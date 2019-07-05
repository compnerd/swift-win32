
import WinSDK

public class RenderContext {
  public let hWnd: HWND
  public private(set) var clientRect: RECT = RECT()
  public private(set) var psPaint: PAINTSTRUCT = PAINTSTRUCT()
  public let hDC: HDC
  
  init(_ hWnd: HWND) {
    self.hWnd = hWnd
    GetClientRect(hWnd, &clientRect)
    self.hDC = BeginPaint(hWnd, &psPaint)
  }

  func fillRect(rect: RECT, color: Color) {
    SelectObject(hDC, GetStockObject(NULL_PEN))
    SelectObject(hDC, GetStockObject(DC_BRUSH))
    SetDCBrushColor(hDC, color.COLORREF)
    Rectangle(hDC, rect.left, rect.top, rect.right, rect.bottom)
  }

  func fillBackground(color: Color) {
    fillRect(rect: self.clientRect, color: color)
  }

  func drawRectangle(rect: RECT, thickness: Int32, color: Color) {
    let pen: HPEN = CreatePen(PS_SOLID,
                              Int32(thickness),
                              color.COLORREF)
    SelectObject(hDC, pen)
    Rectangle(hDC, rect.left, rect.top, rect.right, rect.bottom)
    DeleteObject(pen)
  }

  func drawBorder(thickness: Int32, color: Color) {
    drawRectangle(rect: self.clientRect, thickness: thickness, color: color)
  }

  func drawTextInRect(text: String,
                      rect: RECT,
                      color: Color,
                      format: Int32 = DT_CENTER,
                      align: Int32 = TA_LEFT | TA_TOP | TA_NOUPDATECP) {
    SetTextColor(hDC, color.COLORREF)
    var mutableCopy: [UInt16] = text.LPCWSTR
    var localRect = clientRect
    SetBkMode(hDC, TRANSPARENT)
    SetTextAlign(hDC, UINT(align))
    DrawTextExW(hDC, &mutableCopy, Int32(text.count), &localRect, UInt32(format), nil)
  }

  func drawText(text: String,
                color: Color,
                format: Int32 = DT_CENTER,
                align: Int32 = TA_LEFT | TA_TOP | TA_NOUPDATECP) {
    drawTextInRect(text: text,
                   rect: self.clientRect,
                   color: color,
                   format: format)
  }
  
  deinit {
    EndPaint(self.hWnd, &psPaint)
  }
}
