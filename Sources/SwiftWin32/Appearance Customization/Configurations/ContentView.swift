/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// The requirements for a content view that you create using a configuration.
public protocol ContentView {
  // MARK - Managing the Content Configuration

  /// The current configuration of the view.
  var configuration: ContentConfiguration { get set }
}
