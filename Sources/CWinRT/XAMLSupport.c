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

#include "CWinRT.h"

#include <stdio.h>

#include <strsafe.h>

#define CINTERFACE
#define COBJMACROS

#include <roapi.h>
#include <winstring.h>

#include <windows.ui.xaml.h>
#include <windows.ui.xaml.hosting.h>
#include <windows.ui.xaml.markup.h>

struct CStringHandle {
  HSTRING_HEADER header;
  HSTRING data;
};

static struct CStringHandle CHStringCreate(const wchar_t wszString[]) {
  struct CStringHandle hstring = {0};
  WindowsCreateStringReference(wszString, wcslen(wszString),
                               &hstring.header, &hstring.data);
  return hstring;
}

static void WinRTLog(const wchar_t *message, ...) {
  wchar_t wszBuffer[1024];
  va_list argp;

  va_start(argp, message);
  StringCbVPrintfW(wszBuffer, sizeof(wszBuffer), message, argp);
  va_end(argp);

  OutputDebugStringW(wszBuffer);
}

void CWINRT_ABI WinRT_Initialize(void) {
  HRESULT hr;

  hr = RoInitialize(RO_INIT_MULTITHREADED);
  if (FAILED(hr)) {
    WinRTLog(L"RoInitialize: %#08x\n", hr);
  }
}

void CWINRT_ABI WinRT_Finalize(void) {
  RoUninitialize();
}

struct __x_ABI_CWindows_CUI_CXaml_CHosting_CIDesktopWindowXamlSource* CWINRT_ABI
WinRT_DesktopWindowXamlSourceCreate(void) {
  struct CStringHandle ACID_WindowsUIXamlHostingDesktopWindowXamlSource;
  __x_ABI_CWindows_CUI_CXaml_CHosting_CIDesktopWindowXamlSource* pSource;
  IInspectable* pInspectable;
  HRESULT hr;

  ACID_WindowsUIXamlHostingDesktopWindowXamlSource =
      CHStringCreate(RuntimeClass_Windows_UI_Xaml_Hosting_DesktopWindowXamlSource);

  hr = RoActivateInstance(ACID_WindowsUIXamlHostingDesktopWindowXamlSource.data,
                          &pInspectable);
  if (FAILED(hr)) {
    WinRTLog(L"RoActivateInstance: %#08x\n", hr);
    return NULL;
  }

  hr = IInspectable_QueryInterface(pInspectable,
                                   &IID___x_ABI_CWindows_CUI_CXaml_CHosting_CIDesktopWindowXamlSource,
                                   &pSource);
  IInspectable_Release(pInspectable);
  if (FAILED(hr)) {
    WinRTLog(L"Inspectable::QueryInterface: %#08x\n", hr);
    return NULL;
  }

  return pSource;
}

void CWINRT_ABI
WinRT_DesktopWindowXamlSourceDestroy(struct __x_ABI_CWindows_CUI_CXaml_CHosting_CIDesktopWindowXamlSource* pXamlSource) {
  __x_ABI_CWindows_CUI_CXaml_CHosting_CIDesktopWindowXamlSource_Release(pXamlSource);
}

struct __x_ABI_CWindows_CUI_CXaml_CIUIElement* CWINRT_ABI
WinRT_UIElementCreateFromXaml(const wchar_t *pwszXaml) {
  static __x_ABI_CWindows_CUI_CXaml_CMarkup_CIXamlReaderStatics* pReader = NULL;
  struct __x_ABI_CWindows_CUI_CXaml_CIUIElement* pUIElement;
  IInspectable* pInspectable;
  HRESULT hr;

  if (pReader == NULL) {
    struct CStringHandle ACID_WindowsUIXamlMarkupXamlReader =
        CHStringCreate(RuntimeClass_Windows_UI_Xaml_Markup_XamlReader);
    IInspectable* pInspectable;
    hr = RoGetActivationFactory(ACID_WindowsUIXamlMarkupXamlReader.data,
                                &IID___x_ABI_CWindows_CUI_CXaml_CMarkup_CIXamlReaderStatics,
                                &pReader);
    if (FAILED(hr)) {
      WinRTLog(L"RoGetActivationFactory: %#08x\n", hr);
      return NULL;
    }
  }

  struct CStringHandle xaml = CHStringCreate(pwszXaml);
  hr = __x_ABI_CWindows_CUI_CXaml_CMarkup_CIXamlReaderStatics_Load(pReader,
                                                                   xaml.data,
                                                                   &pInspectable);
  if (FAILED(hr)) {
    WinRTLog(L"__x_ABI_CWindows_CUI_CXaml_CMarkup_CIXamlReaderStatics_Load: %#08x",
             hr);
    return NULL;
  }

  hr = IInspectable_QueryInterface(pInspectable,
                                   &IID___x_ABI_CWindows_CUI_CXaml_CIUIElement,
                                   &pUIElement);
  IInspectable_Release(pInspectable);
  if (FAILED(hr)) {
    WinRTLog(L"Inspectable::QueryInterface: %#08x\n", hr);
    return NULL;
  }

  return pUIElement;
}

void CWINRT_ABI
WinRT_UIElementDestroy(struct __x_ABI_CWindows_CUI_CXaml_CIUIElement* pUIElement) {
  __x_ABI_CWindows_CUI_CXaml_CIUIElement_Release(pUIElement);
}
