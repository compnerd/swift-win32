// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// Constants to specify metrics to use for appearance.
public enum BarMetrics: Int {
  /// Specifies default metrics for the device.
  case `default`

  /// Specifies metrics when using the phone idiom.
  case compact

  /// Specifies default metrics for the device for bars with the
  /// prompt property, such as `NavigationBar` and `SearchBar`.
  case defaultPrompt

  /// Specifies metrics for bars with the prompt property when using
  /// the phone idiom, such as `NavigationBar` and `SearchBar`.
  case compactPrompt
}

extension BarMetrics {
  /// Specifies metrics for landscape orientation using the phone idiom.
  @available(*, unavailable)
  public static var landscapePhone: BarMetrics {
    return .compact
  }

  /// Specifies metrics for landscape orientation using the phone idiom
  /// for bars with the prompt property, such as `NavigationBar` and
  /// `SearchBar`.
  @available(*, unavailable)
  public static var landscapePhonePrompt: BarMetrics {
    return .compactPrompt
  }
}
