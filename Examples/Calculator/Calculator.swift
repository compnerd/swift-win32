/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import SwiftWin32
import Foundation

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

  private var window: Window

  private var txtResult: TextField = {
    let txtResult = TextField(frame: Rect(x: 34, y: 32, width: 128, height: 24))
    txtResult.font = Font(name: "Consolas", size: Font.systemFontSize)
    txtResult.textAlignment = .right
    txtResult.text = "0"
    return txtResult
  }()

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

  public init(windowScene: WindowScene) {
    self.window = Window(windowScene: windowScene)

    self.window.rootViewController = ViewController()
    self.window.rootViewController?.title = "Calculator"

    self.window.addSubview(self.txtResult)

    self.window.addSubviews(self.btnDigits)
    self.btnDigits.forEach {
      $0.addTarget(self, action: Calculator.onDigitPress(_:_:),
                   for: .primaryActionTriggered)
    }
    self.window.addSubviews(self.btnOperations)
    self.btnOperations.forEach {
      $0.addTarget(self, action: Calculator.onOperationPress(_:_:),
                   for: .primaryActionTriggered)
    }
    self.window.addSubview(self.btnDecimal)
    self.btnDecimal.addTarget(self, action: Calculator.onDecimalPress(_:_:),
                              for: .primaryActionTriggered)

    self.window.makeKeyAndVisible()
  }

  private func onDigitPress(_ sender: Button, _: Control.Event) {
    guard let input = self.btnDigits.firstIndex(of: sender) else {
      fatalError("invalid target: \(self) for sender: \(sender)")
    }

    self.state[keyPath: self.state.operand] += String(input)

    self.txtResult.text =
        (NSDecimalNumber(string: self.state[keyPath: self.state.operand])
            as Decimal).description
  }

  private func onOperationPress(_ sender: Button, _: Control.Event) {
    switch self.btnOperations.firstIndex(of: sender)! {
    case 0: /* AC */
      self.state = CalculatorState()
      self.txtResult.text = "0"
    case 1: /* +/- */
      var value: Decimal =
          NSDecimalNumber(string: self.state[keyPath: self.state.operand])
              as Decimal
      value.negate()
      self.state[keyPath: self.state.operand] = value.description
      self.txtResult.text = value.description
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
      self.txtResult.text =
          (NSDecimalNumber(string: self.state.evaluate()) as Decimal)
              .description
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
final class CalculatorDelegate: ApplicationDelegate, SceneDelegate {
  private var calculator: Calculator?

  func scene(_ scene: Scene, willConnectTo session: SceneSession,
             options: Scene.ConnectionOptions) {
    guard let windowScene = scene as? WindowScene else { return }

    let size: Size = Size(width: 192, height: 264)
    windowScene.sizeRestrictions?.minimumSize = size
    windowScene.sizeRestrictions?.maximumSize = size

    self.calculator = Calculator(windowScene: windowScene)
  }
}
