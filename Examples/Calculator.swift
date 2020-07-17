/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
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

import func WinSDK.GetWindowTextW
import let WinSDK.CW_USEDEFAULT
import struct WinSDK.DWORD
import struct WinSDK.HWND
import struct WinSDK.LPARAM
import struct WinSDK.LRESULT
import struct WinSDK.WCHAR
import struct WinSDK.WPARAM

import SwiftWin32
import Foundation

private extension View {
  func addSubviews(_ views: [View]) {
    _ = views.map { self.addSubview($0) }
  }
}

private enum CalculatorOperation {
case undefined
case addition
case substraction
case multiplication
case division
}

private struct CalculatorState {
  var lhs: String = ""
  var rhs: String = ""
  var operand: WritableKeyPath<Self, String> = \.lhs
  var operation: CalculatorOperation = .undefined {
    willSet { self.operand = (newValue == .undefined) ? \.lhs : \.rhs }
  }

  mutating func evaluate() -> String {
    var f: ((Double, Double) -> Double)?

    switch self.operation {
    case .undefined:      break
    case .addition:       f = { $0 + $1 }
    case .substraction:   f = { $0 - $1 }
    case .multiplication: f = { $0 * $1 }
    case .division:       f = { $0 / $1 }
    }

    if let f = f {
      lhs = String(f(Double(lhs)!, Double(rhs)!))
    }
    rhs = ""
    operation = .undefined

    return lhs
  }
}

private class CalculatorWindowDelegate: WindowDelegate {
  weak var calculator: Calculator?

  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM)
      -> LRESULT {
    guard let calculator = self.calculator else { return 0 }

    let sender: HWND? = HWND(bitPattern: Int(lParam))

#if swift(<5.3)
    var buffer: [WCHAR] = Array<WCHAR>(repeating: 0, count: 32)
    GetWindowTextW(sender, &buffer, CInt(buffer.count))
#else
    let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: 32) {
      $1 = Int(GetWindowTextW(sender, $0.baseAddress!, CInt($0.count)))
    }
#endif

    let szText: String = String(decodingCString: buffer, as: UTF16.self)
    switch szText {
    case "+": calculator.state.operation = .addition
    case "-": calculator.state.operation = .substraction
    case "x": calculator.state.operation = .multiplication
    case "÷": calculator.state.operation = .division
    case ".":
      calculator.state[keyPath: calculator.state.operand] += szText
      calculator.txtResult.text =
          calculator.state[keyPath: calculator.state.operand]
    case "0"..."9":
      calculator.state[keyPath: calculator.state.operand] += szText

      let value: Double =
          Double(calculator.state[keyPath: calculator.state.operand])!
      calculator.txtResult.text =
          NumberFormatter.localizedString(from: NSNumber(value: value),
                                          number: .decimal)
    case "⁺∕₋":
      let value: Double =
          Double(calculator.state[keyPath: calculator.state.operand]) ?? 0.0
      let number: NSNumber = NSNumber(value: -1.0 * value)

      calculator.state[keyPath: calculator.state.operand] =
          NumberFormatter().string(from: number)!
      calculator.txtResult.text =
          NumberFormatter.localizedString(from: number, number: .decimal)
    case "%":
      if Double(calculator.state.lhs) == 0.0 { break }
      calculator.state.operation = .division
      calculator.state.rhs = "100"
      fallthrough
    case "=":
      let value: Double = Double(calculator.state.evaluate())!
      calculator.txtResult.text =
          NumberFormatter.localizedString(from: NSNumber(value: value),
                                          number: .decimal)
    default:
      // TODO(compnerd) handle the invalid operation
      fatalError("unreachable")
    }

    return 0
  }
}

private class Calculator {
  internal var state: CalculatorState = CalculatorState()

  private var delegate: CalculatorWindowDelegate = CalculatorWindowDelegate()

  private var window: Window =
      Window(frame: Rect(x: Double(CW_USEDEFAULT), y: Double(CW_USEDEFAULT),
                         width: 204, height: 264), title: "Calculator")

  internal var txtResult: TextField =
      TextField(frame: Rect(x: 34, y: 32, width: 128, height: 24))

  private var btnDigits: [Button] = [
      Button(frame: Rect(x: 32, y: 192, width: 64, height: 32), title: "0"),
      Button(frame: Rect(x: 32, y: 160, width: 32, height: 32), title: "1"),
      Button(frame: Rect(x: 64, y: 160, width: 32, height: 32), title: "2"),
      Button(frame: Rect(x: 96, y: 160, width: 32, height: 32), title: "3"),
      Button(frame: Rect(x: 32, y: 128, width: 32, height: 32), title: "4"),
      Button(frame: Rect(x: 64, y: 128, width: 32, height: 32), title: "5"),
      Button(frame: Rect(x: 96, y: 128, width: 32, height: 32), title: "6"),
      Button(frame: Rect(x: 32, y: 96, width: 32, height: 32), title: "7"),
      Button(frame: Rect(x: 64, y: 96, width: 32, height: 32), title: "8"),
      Button(frame: Rect(x: 96, y: 96, width: 32, height: 32), title: "9"),
  ]

  private var btnDecimal: Button =
      Button(frame: Rect(x: 96, y: 192, width: 32, height: 32), title: ".")

  private var btnOperations: [Button] = [
      Button(frame: Rect(x: 64, y: 64, width: 32, height: 32), title: "⁺∕₋"),
      Button(frame: Rect(x: 96, y: 64, width: 32, height: 32), title: "%"),
      Button(frame: Rect(x: 128, y: 64, width: 32, height: 32), title: "÷"),
      Button(frame: Rect(x: 128, y: 96, width: 32, height: 32), title: "x"),
      Button(frame: Rect(x: 128, y: 128, width: 32, height: 32), title: "-"),
      Button(frame: Rect(x: 128, y: 160, width: 32, height: 32), title: "+"),
      Button(frame: Rect(x: 128, y: 192, width: 32, height: 32), title: "="),
  ]

  public init() {
    self.delegate.calculator = self

    self.window.delegate = self.delegate

    self.window.addSubview(self.txtResult)
    self.txtResult.font = Font(name: "Consolas", size: 14)
    self.txtResult.textAlignment = .right

    self.window.addSubviews(self.btnDigits)
    self.window.addSubviews(self.btnOperations)

    self.window.addSubview(self.btnDecimal)
  }
}

private var calculator: Calculator?

@main
final class CalculatorDelegate: ApplicationDelegate {
  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    calculator = Calculator()
    return true
  }
}
