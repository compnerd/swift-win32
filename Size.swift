
public struct Size {
  public static let zero: Size = Size(width: 0, height: 0)

  public var height: Double
  public var width: Double

  public init(width: Double, height: Double) {
    self.height = height
    self.width = width
  }
}

