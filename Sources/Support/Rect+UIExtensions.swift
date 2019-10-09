
import WinSDK

internal extension Rect {
  public static let `default`: Rect =
      Rect(x: Double(CW_USEDEFAULT), y: Double(CW_USEDEFAULT),
           width: Double(CW_USEDEFAULT), height: Double(CW_USEDEFAULT))
}
