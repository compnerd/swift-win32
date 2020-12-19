/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import SwiftWin32
import Foundation

import func WinSDK.MessageBoxW
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
final class UICatalog: ApplicationDelegate, SceneDelegate {
  var window: Window!

  lazy var label: Label =
      Label(frame: Rect(x: 4.0, y: 12.0, width: 64.0, height: 16.0),
            title: "Read Me:")

  lazy var button: Button =
      Button(frame: Rect(x: 72.0, y: 4.0, width: 96.0, height: 32.0),
             title: "Press Me!")

  lazy var checkbox: Switch =
      Switch(frame: Rect(x: 4.0, y: 40.0, width: 256.0, height: 24.0))

  lazy var progress: ProgressView =
      ProgressView(frame: Rect(x: 4.0, y: 68.0, width: 256.0, height: 20.0))

  lazy var textfield: TextField =
      TextField(frame: Rect(x: 4.0, y: 92.0, width: 254.0, height: 17.0))

  lazy var password: TextField =
      TextField(frame: Rect(x: 4.0, y: 113.0, width: 254.0, height: 17.0))

  lazy var textview: TextView =
      TextView(frame: Rect(x: 4.0, y: 134.0, width: 254.0, height: 72.0))

  lazy var slider: Slider =
      Slider(frame: Rect(x: 4.0, y: 210.0, width: 256.0, height: 24.0))

  lazy var picker: DatePicker =
      DatePicker(frame: Rect(x: 4.0, y: 238.0, width: 256.0, height: 32.0))

  lazy var stepperLabel: Label =
      Label(frame: Rect(x: 4.0, y: 274.0, width: 128.0, height: 32.0))
  lazy var stepper: Stepper =
      Stepper(frame: Rect(x: 197.0, y: 274.0, width: 64.0, height: 32.0))

  lazy var tableview: TableView =
      TableView(frame: Rect(x: 4.0, y: 310.0, width: 254.0, height: 48.0),
                style: .plain)

  lazy var imageview: ImageView = {
#if SWIFT_PACKAGE
    let bundle: Bundle = Bundle.module
#else
    let bundle: Bundle = Bundle.main
#endif
    guard let resource: URL =
        bundle.url(forResource: "CoffeeCup", withExtension: "jpg") else {
      fatalError("Unable to load resource `CoffeeCup.jpg`")
    }
    let image: Image? = Image(contentsOfFile: resource.path)
    let view = ImageView(image: image)
    view.frame = Rect(x: 64.0, y: 362.0, width: 128.0, height: 128.0)
    return view
  }()

  func scene(_ scene: Scene, willConnectTo session: SceneSession,
             options: Scene.ConnectionOptions) {
    guard let windowScene = scene as? WindowScene else { return }

    // Set the preferred window size and restrict resizing by setting the
    // minimum and maximum to the same value.
    let size: Size = Size(width: 265, height: 494)
    windowScene.sizeRestrictions?.minimumSize = size
    windowScene.sizeRestrictions?.maximumSize = size

    self.window = Window(windowScene: windowScene)

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
    window.addSubview(self.tableview)
    window.addSubview(self.imageview)

    self.label.font = Font(name: "Consolas", size: 10)!

    self.button.addTarget(self, action: UICatalog.pressMe(_:),
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
    self.stepper.addTarget(self, action: UICatalog.stepperValueDidChange(_:),
                           for: .valueChanged)

    self.tableview.dataSource = self

    window.makeKeyAndVisible()
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

extension UICatalog: TableViewDataSource {
  public func tableView(_ tableView: TableView,
                        numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  public func tableView(_ tableView: TableView,
                        cellForRowAt indexPath: IndexPath) -> TableViewCell {
    let cell = TableViewCell(style: .default, reuseIdentifier: nil)
    cell.addSubview(Button(frame: Rect(x: 0, y: 0, width: 80, height: 32),
                           title: "Button \(indexPath.row)"))
    cell.frame = Rect(x: 0, y: 0, width: 80, height: 32)
    return cell
  }
}
