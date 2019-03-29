
public class Application {
  public static var shared: Application = Application()
  public var delegate: ApplicationDelegate?
}

public extension Application {
  struct LaunchOptionsKey: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

