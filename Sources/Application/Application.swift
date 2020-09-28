/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public class Application: Responder {
  /// Getting the App Instance
  public static var shared: Application = Application()

  /// Managing the App's Behaviour
  public var delegate: ApplicationDelegate?

  /// Getting the Application State
  public internal(set) var state: Application.State

  /// Getting App Windows
  public internal(set) var keyWindow: Window?
  public internal(set) var windows: [Window]

  override public required init() {
    self.state = .active
    self.windows = []
    super.init()
  }

  // Responder Chain
  override public var next: Responder? {
    if let responder = self.delegate as? Responder,
       !(self.delegate is View), !(self.delegate is ViewController),
       !(self.delegate === self) {
      return responder
    }
    return nil
  }
}

extension Application {
  /// The running states of the application
  public enum State: Int {
  /// The application is running in the foreground
  case active
  case inactive
  /// The application is running in the background
  case background
  }
}
