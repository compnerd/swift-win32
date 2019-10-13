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
      Button(frame: Rect(x: 64, y: 0, width: 64, height: 32), title: "Press Me!")
  lazy var label: Label =
      Label(frame: Rect(x: 0, y: 0, width: 64, height: 8), title: "Read Me:")
  lazy var delegate = EventHandler()

  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    window.addSubview(self.label)
    window.addSubview(self.button)
    window.delegate = delegate
    return true
  }
}

ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, SwiftApplicationDelegate())
