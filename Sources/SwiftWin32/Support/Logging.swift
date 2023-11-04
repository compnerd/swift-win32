// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if swift(>=5.9)
internal import Logging
#else
@_implementationOnly
import Logging
#endif

internal let log: Logger = Logger(label: "org.compnerd.swift-win32")
