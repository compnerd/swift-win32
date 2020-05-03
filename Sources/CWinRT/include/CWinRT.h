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

#ifndef WinRT_CWinRT_h
#define WinRT_CWinRT_h

#include "CWinRTMacros.h"

CWINRT_BEGIN_DECLS

void CWINRT_ABI WinRT_Initialize(void);

void CWINRT_ABI WinRT_Finalize(void);

struct __x_ABI_CWindows_CUI_CXaml_CHosting_CIDesktopWindowXamlSource* CWINRT_ABI
WinRT_DesktopWindowXamlSourceCreate(void);

void CWINRT_ABI
WinRT_DesktopWindowXamlSourceDestroy(struct __x_ABI_CWindows_CUI_CXaml_CHosting_CIDesktopWindowXamlSource*);

struct __x_ABI_CWindows_CUI_CXaml_CIUIElement* CWINRT_ABI
WinRT_UIElementCreateFromXaml(const unsigned short *pwszXaml);

void CWINRT_ABI
WinRT_UIElementDestroy(struct __x_ABI_CWindows_CUI_CXaml_CIUIElement* pUIElement);

CWINRT_END_DECLS

#endif
