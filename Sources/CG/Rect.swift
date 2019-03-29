
public struct Rect {
  public static let zero: Rect = Rect(x: 0, y: 0, width: 0, height: 0)

  public var x: Double
  public var y: Double
  public var height: Double
  public var width: Double

  public init(x: Double, y: Double, width: Double, height: Double) {
    self.x = x
    self.y = y
    self.height = height
    self.width = width
  }
}

