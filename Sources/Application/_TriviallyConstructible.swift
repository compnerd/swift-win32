/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

// TODO(compnerd) determine if there is a way to avoid this conformance.  It is
// required to initialize the class from `ApplicationMain` which takes class
// names.
public protocol _TriviallyConstructible {
  init()
}
