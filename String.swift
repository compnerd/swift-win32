
import ucrt

public extension String {
  var LPWSTR: UnsafeMutableBufferPointer<UInt16> {
    let duplicate = self.withCString(encodedAs: UTF16.self) { _wcsdup($0) }
    return UnsafeMutableBufferPointer<UInt16>(start: duplicate,
                                              count: self.utf16.count)
  }
}

