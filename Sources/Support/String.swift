
import ucrt

public extension String {
  var LPCWSTR: [UInt16] {
    var array: [UInt16] =
        Array<UInt16>(repeating: 0, count: self.utf16.count + 1)
    _ = self.withCString(encodedAs: UTF16.self) {
      wcscpy_s(&array, array.count, $0)
    }
    return array
  }
}

