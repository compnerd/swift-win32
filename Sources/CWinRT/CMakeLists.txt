add_library(CWinRT STATIC
  XAMLSupport.c
  WinRTAugmentation.cc)
target_include_directories(CWinRT PUBLIC
  include)
target_link_libraries(CWinRT PRIVATE
  WindowsApp)
