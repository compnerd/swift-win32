
import WinSDK
import SwiftWin32

class SwiftApplicationDelegate: ApplicationDelegate {
  var window: Window?
  var button: Button?
  var label: Label?

  class HelloSwiftDelegate: WindowDelegate {
    override func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
      PostQuitMessage(0)
      return 0
    }
  }

  class MyBtnDelegate: ButtonDelegate {
    var red: Bool = true

    override func OnLeftButtonDown(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
      red = !red
      if red {
        self.view?.backgroundColor = #colorLiteral(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
      } else {
        self.view?.backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
      }
      return 0
    }
  }

  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    self.window = Window(title: "Swift Window")
    self.button = Button(frame: Rect(x: 100, y: 100, width: 100, height: 100))
    self.label = Label(frame: Rect(x: 0, y: 0, width: 100, height: 100))

    self.button?.backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)

    self.button?.text = "BUTTON HI"
    self.label?.text = "LABEL HI"
    self.label?.textColor = #colorLiteral(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    self.label?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    self.label?.borderColor = #colorLiteral(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
    self.label?.borderThickness = 10

    self.window?.addSubview(self.button!)
    self.window?.addSubview(self.label!)

    self.window?.delegate = HelloSwiftDelegate()
    self.button?.delegate = MyBtnDelegate()

    self.button?.show()
    self.label?.show()
    self.window?.show()
    return true
  }
}

ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil,
                SwiftApplicationDelegate())
