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

import SwiftWin32
import Foundation

import let WinSDK.CW_USEDEFAULT

private extension View {
  func addSubviews(_ views: [View]) {
    _ = views.map { self.addSubview($0) }
  }
}

private extension Button {
  convenience init(frame: Rect = .zero, title: String) {
    self.init(frame: frame)
    setTitle(title, forState: .normal)
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

private class Calculator {
  private var state: CalculatorState = CalculatorState()

  private var window: Window =
      Window(frame: Rect(x: Double(CW_USEDEFAULT), y: Double(CW_USEDEFAULT),
                         width: 192, height: 264))

  private var txtResult: TextField =
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
      Button(frame: Rect(x: 32, y: 64, width: 32, height: 32), title: "AC"),
      Button(frame: Rect(x: 64, y: 64, width: 32, height: 32), title: "⁺∕₋"),
      Button(frame: Rect(x: 96, y: 64, width: 32, height: 32), title: "%"),
      Button(frame: Rect(x: 128, y: 64, width: 32, height: 32), title: "÷"),
      Button(frame: Rect(x: 128, y: 96, width: 32, height: 32), title: "x"),
      Button(frame: Rect(x: 128, y: 128, width: 32, height: 32), title: "-"),
      Button(frame: Rect(x: 128, y: 160, width: 32, height: 32), title: "+"),
      Button(frame: Rect(x: 128, y: 192, width: 32, height: 32), title: "="),
  ]

  public init() {
    self.window.rootViewController = ViewController()
    self.window.rootViewController?.title = "Calculator"

    self.window.addSubview(self.txtResult)
    self.txtResult.font = Font(name: "Consolas", size: Font.systemFontSize)
    self.txtResult.textAlignment = .right
    self.txtResult.text = "0"

    self.window.addSubviews(self.btnDigits)
    _ = self.btnDigits.map {
      $0.addTarget(self, action: Calculator.onDigitPress(_:_:),
                   for: .primaryActionTriggered)
    }
    self.window.addSubviews(self.btnOperations)
    _ = self.btnOperations.map {
      $0.addTarget(self, action: Calculator.onOperationPress(_:_:),
                   for: .primaryActionTriggered)
    }

    self.window.addSubview(self.btnDecimal)
    self.btnDecimal.addTarget(self, action: Calculator.onDecimalPress(_:_:),
                              for: .primaryActionTriggered)

    self.window.makeKeyAndVisible()
  }

  private func onDigitPress(_ sender: Button, _: Control.Event) {
    let input = self.btnDigits.firstIndex(of: sender)!

    self.state[keyPath: self.state.operand] += String(input)

    let value: Double = Double(self.state[keyPath: self.state.operand])!
    self.txtResult.text =
        NumberFormatter.localizedString(from: NSNumber(value: value),
                                        number: .decimal)
  }

  private func onOperationPress(_ sender: Button, _: Control.Event) {
    switch self.btnOperations.firstIndex(of: sender)! {
    case 0: /* AC */
      self.state = CalculatorState()
      self.txtResult.text = "0"
    case 1: /* +/- */
      let value: Double = Double(self.state[keyPath: self.state.operand])!
      let number: NSNumber = NSNumber(value: -1.0 * value)

      self.state[keyPath: self.state.operand] =
          NumberFormatter.localizedString(from: number, number: .decimal)
      self.txtResult.text =
          NumberFormatter.localizedString(from: number, number: .decimal)
    case 3: /* ÷ */
      self.state.operation = .division
    case 4: /* x */
      self.state.operation = .multiplication
    case 5: /* - */
      self.state.operation = .substraction
    case 6: /* + */
      self.state.operation = .addition
    case 2: /* % */
      if Double(self.state.lhs) == 0.0 { break }
      self.state.operation = .division
      self.state.rhs = "100"
      fallthrough
    case 7: /* = */
      let value: Double = Double(self.state.evaluate())!
      self.txtResult.text =
          NumberFormatter.localizedString(from: NSNumber(value: value),
                                          number: .decimal)
    default:
      fatalError("unknown operation \(self.btnOperations.firstIndex(of: sender)!)")
    }
  }

  private func onDecimalPress(_ sender: Button, _: Control.Event) {
    self.state[keyPath: self.state.operand] += "."
    self.txtResult.text = self.state[keyPath: self.state.operand]
  }
}

@main
final class CalculatorDelegate: ApplicationDelegate {
  private var calculator: Calculator?

  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    calculator = Calculator()
    return true
  }
}
