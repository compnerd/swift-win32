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

import WinSDK
import SwiftWin32

class EventHandler: WindowDelegate {
  func OnDestroy(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM)
      -> LRESULT {
    PostQuitMessage(0)
    return 0
  }

  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM)
      -> LRESULT {
    MessageBoxW(nil, "Swift/Win32 Demo!".LPCWSTR,
                "Swift/Win32 MessageBox!".LPCWSTR, UINT(MB_OK))
    return 0
  }
}

class SwiftApplicationDelegate: ApplicationDelegate {
  lazy var window: Window =
      Window(frame: .default, title: "Swift/Win32 Window")
  lazy var button: Button =
      Button(frame: Rect(x: 96.0, y: 4.0, width: 32.0, height: Double(CW_USEDEFAULT)),
             title: "Press Me!")
  lazy var label: Label =
      Label(frame: Rect(x: 4.0, y: 12.0, width: 32.0, height: Double(CW_USEDEFAULT)),
            title: "Read Me:")
  lazy var progress: ProgressView =
      ProgressView(frame: Rect(x: 4.0, y: 48.0, width: 256.0, height: Double(CW_USEDEFAULT)))
  lazy var textfield: TextField =
      TextField(frame: Rect(x: 4.0, y: 96.0, width: 256.0, height: Double(CW_USEDEFAULT)))
  lazy var textview: TextView =
      TextView(frame: Rect(x: 4.0, y: 128.0, width: 256.0, height: 64.0))
  lazy var delegate = EventHandler()

  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    window.addSubview(self.label)
    window.addSubview(self.button)
    window.addSubview(self.progress)
    window.addSubview(self.textfield)
    window.addSubview(self.textview)
    window.delegate = delegate
    self.textfield.text = "Introducing Swift/Win32"
    self.textview.text = """
Lorem ipsum dolor sit amet, consectetur adipiscicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua.\r\n

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat.\r\n

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur.\r\n

Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
deserunt mollit anim id est laborum.\r\n
"""
    self.progress.setProgress(0.5, animated: false)
    return true
  }
}

ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, SwiftApplicationDelegate())
