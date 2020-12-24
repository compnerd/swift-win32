/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// Constants that specify an edge or a set of edges, taking the user interface
/// layout direction into account.
public struct DirectionalRectEdge: OptionSet {
  public let rawValue: UInt

  public init(rawValue: UInt) {
    self.rawValue = rawValue
  }
}

extension DirectionalRectEdge {
  /// No specified edge.
  public static var none: DirectionalRectEdge {
    DirectionalRectEdge(rawValue: 0 << 0)
  }

  /// The top edge.
  public static var top: DirectionalRectEdge {
    DirectionalRectEdge(rawValue: 1 << 0)
  }

  /// The leading edge.
  public static var leading: DirectionalRectEdge {
    DirectionalRectEdge(rawValue: 1 << 1)
  }

  /// The bottom edge.
  public static var bottom: DirectionalRectEdge {
    DirectionalRectEdge(rawValue: 1 << 2)
  }

  /// The trailing edge.
  public static var trailing: DirectionalRectEdge {
    DirectionalRectEdge(rawValue: 1 << 3)
  }

  /// All edges.
  public static var all: DirectionalRectEdge {
    [.top, .leading, .bottom, .trailing]
  }
}
