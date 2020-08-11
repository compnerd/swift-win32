/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

import SwiftWin32

import func WinSDK.MessageBoxW
import let WinSDK.CW_USEDEFAULT
import let WinSDK.MB_OK
import struct WinSDK.UINT

private extension Button {
  convenience init(frame: Rect = .zero, title: String) {
    self.init(frame: frame)
    setTitle(title, forState: .normal)
  }
}

private extension Label {
  convenience init(frame: Rect, title: String) {
    self.init(frame: frame)
    self.text = title
  }
}

@main
final class SwiftApplicationDelegate: ApplicationDelegate {
  var window: Window =
      Window(frame: Rect(x: Double(CW_USEDEFAULT), y: Double(CW_USEDEFAULT),
                         width: 444, height: 555))

  lazy var label: Label =
      Label(frame: Rect(x: 4.0, y: 12.0, width: 64.0, height: 16.0),
            title: "Read Me:")

  lazy var button: Button =
      Button(frame: Rect(x: 72.0, y: 4.0, width: 96.0, height: 32.0),
             title: "Press Me!")
  lazy var checkbox: Switch =
      Switch(frame: Rect(x: 4.0, y: 40.0, width: 256.0, height: 16.0))

  lazy var progress: ProgressView =
      ProgressView(frame: Rect(x: 4.0, y: 64.0, width: 256.0, height: 20.0))

  lazy var textfield: TextField =
      TextField(frame: Rect(x: 4.0, y: 94.0, width: 254.0, height: 16.0))

  lazy var password: TextField =
      TextField(frame: Rect(x: 4.0, y: 120.0, width: 254.0, height: 16.0))

  lazy var textview: TextView =
      TextView(frame: Rect(x: 4.0, y: 144.0, width: 254.0, height: 72.0))

  lazy var slider: Slider =
      Slider(frame: Rect(x: 4.0, y: 224.0, width: 256.0, height: 24.0))

  lazy var picker: DatePicker =
      DatePicker(frame: Rect(x: 4.0, y: 254.0, width: 256.0, height: 32.0))

  lazy var stepperLabel: Label =
      Label(frame: Rect(x: 4.0, y: 292.0, width: 128.0, height: 48.0))
  lazy var stepper: Stepper =
      Stepper(frame: Rect(x: 197.0, y: 290.0, width: 64.0, height: 32.0))

  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    window.rootViewController = ViewController()
    window.rootViewController?.title = "UICatalog"

    window.addSubview(self.label)
    window.addSubview(self.button)
    window.addSubview(self.checkbox)
    window.addSubview(self.progress)
    window.addSubview(self.textfield)
    window.addSubview(self.password)
    window.addSubview(self.textview)
    window.addSubview(self.slider)
    window.addSubview(self.picker)
    window.addSubview(self.stepperLabel)
    window.addSubview(self.stepper)

    self.label.font = Font(name: "Consolas", size: 10)!

    self.button.addTarget(self, action: SwiftApplicationDelegate.pressMe(_:),
                          for: .primaryActionTriggered)

    self.checkbox.title = "Check me out"

    self.textfield.text = "Introducing Swift/Win32"
    self.textfield.font = Font(name: "Cascadia Code", size: 10)

    self.password.isSecureTextEntry = true
    self.password.font = Font(name: "Cascadia Code", size: 10)
    self.password.placeholder = "Password"

    self.textview.text = """
Lorem ipsum dolor sit amet, consectetur adipiscicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""
    self.textview.font = Font(name: "MS Comic Sans", size: 10)

    self.progress.setProgress(0.5, animated: false)

    self.slider.minimumValue = 0.0
    self.slider.maximumValue = 100.0
    self.slider.value = 48.0

    self.stepperLabel.text = String(Int(self.stepper.value))
    self.stepper.addTarget(self,
                           action: SwiftApplicationDelegate.stepperValueDidChange(_:),
                           for: .valueChanged)

    window.makeKeyAndVisible()

    return true
  }

  func applicationDidBecomeActive(_: Application) {
    print("Good morning!")
  }

  func applicationDidEnterBackground(_: Application) {
    print("Good night!")
  }

  func applicationWillTerminate(_: Application) {
    print("Goodbye cruel world!")
  }

  private func pressMe(_: Button?) {
    MessageBoxW(nil, "Swift/Win32 Demo!".LPCWSTR,
                "Swift/Win32 MessageBox!".LPCWSTR, UINT(MB_OK))
  }

  private func stepperValueDidChange(_ stepper: Stepper) {
    self.stepperLabel.text = String(Int(stepper.value))
  }
}
