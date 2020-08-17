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

public class Responder {
  /// Managing the Responder Chain

  /// Returns the next responder in the responder chain, or `nil` if there is no
  /// next responder.
  public var next: Responder? { nil }

  /// Indicates whether this object is the first responder.
  public var isFirstResponder: Bool { return self.next === self }

  /// Indiciates whether ths object can become the first responder.
  public var canBecomeFirstResponder: Bool { false }

  /// Indicates whether this object is willing to relinquish first-responder
  /// status.
  public var canResignFirstResponder: Bool { true }

  /// Results to make this object the first responder in its window.
  public func becomeFirstResponder() -> Bool {
    guard !self.isFirstResponder else { return true }
    guard self.canBecomeFirstResponder else { return false }
    return true
  }

  /// Notifies the object that it has been asked to relinquish its status as
  /// first responder in its window.
  public func resignFirstResponder() -> Bool {
    return true
  }
}
