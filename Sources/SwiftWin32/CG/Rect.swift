// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

public struct Rect {
  public static let zero: Rect = Rect(x: 0, y: 0, width: 0, height: 0)

  public var origin: Point
  public var size: Size

  public init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }

  public init(x: Double, y: Double, width: Double, height: Double) {
    self.init(origin: Point(x: x, y: y),
              size: Size(width: width, height: height))
  }

  public init(x: Int, y: Int, width: Int, height: Int) {
    self.init(origin: Point(x: x, y: y),
              size: Size(width: Double(width), height: Double(height)))
  }

  public func applying(_ transform: AffineTransform) -> Rect {
    let points: [Point] = [
      self.origin,
      self.origin + Point(x: self.size.width, y: 0),
      self.origin + Point(x: 0, y: self.size.height),
      self.origin + Point(x: self.size.width, y: self.size.height),
    ].map { $0.applying(transform) }

    let xs: [Double] = points.map { $0.x }
    let ys: [Double] = points.map { $0.y }
    
    return Rect(origin: Point(x: xs.min()!, y: ys.min()!),
                size: Size( width: xs.max()! - xs.min()!,
                            height: ys.max()! - ys.min()!))
  }
}

extension Rect {
  public var midX: Double {
    return self.origin.x + (self.size.width / 2)
  }

  public var midY: Double {
    return self.origin.y + (self.size.height / 2)
  }
}

extension Rect: Equatable {
}

extension Rect: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Rect(origin: \(origin), size: \(size))"
  }
}
