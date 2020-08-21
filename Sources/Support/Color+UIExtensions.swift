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

import WinSDK

extension COLORREF {
  fileprivate init(red r: Double, green g: Double, blue b: Double) {
    self = 0
         | (DWORD((b * 255.0).rounded(.toNearestOrAwayFromZero)) << 16)
         | (DWORD((g * 255.0).rounded(.toNearestOrAwayFromZero)) <<  8)
         | (DWORD((r * 255.0).rounded(.toNearestOrAwayFromZero)) <<  0)
  }
}

extension Color {
  internal var COLORREF: COLORREF {
    switch self.value {
    case .rgba(let r, let g, let b, _):
      return WinSDK.COLORREF(red: r, green: g, blue: b)
    case .hsba(let h, let s, let b, _):
      func f(_ n: Double) -> Double {
        let k = ucrt.fmod(n + (6.0 * h), 6.0)
        return b - b * s * max(0, min(k, 4 - k, 1))
      }

      return WinSDK.COLORREF(red: f(5.0), green: f(3.0), blue: f(1.0))
    case .gray(let w, _):
      return WinSDK.COLORREF(red: w * 255.0, green: w * 255.0, blue: w * 255.0)
    }
  }
}
