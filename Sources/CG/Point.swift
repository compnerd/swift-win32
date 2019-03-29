
public struct Point {
  public static let zero: Point = Point(x: 0, y: 0)

  public var x: Double
  public var y: Double

  public init(x: Double, y: Double) {
    self.x = x
    self.y = y
  }
}

