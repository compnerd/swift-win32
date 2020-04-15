cmake_minimum_required(VERSION 3.16.0)

project(SwiftWin32 LANGUAGES Swift)

option(ENABLE_LOGGING "Enable logging through swift-log" NO)

set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)

if(ENABLE_LOGGING)
  find_package(swift-log CONFIG QUIET)
endif()

add_library(SwiftWin32 SHARED
  Sources/Application/Application.swift
  Sources/Application/ApplicationDelegate.swift
  Sources/Application/ApplicationMain.swift
  Sources/UI/Button.swift
  Sources/UI/Color.swift
  Sources/UI/Control.swift
  Sources/UI/EdgeInsets.swift
  Sources/UI/Font.swift
  Sources/UI/Label.swift
  Sources/UI/ProgressView.swift
  Sources/UI/Screen.swift
  Sources/UI/Slider.swift
  Sources/UI/TextField.swift
  Sources/UI/TextView.swift
  Sources/UI/View.swift
  Sources/UI/Window.swift
  Sources/UI/WindowClass.swift)
target_sources(SwiftWin32 PRIVATE
  Sources/CG/AffineTransform.swift
  Sources/CG/Point.swift
  Sources/CG/Rect.swift
  Sources/CG/Size.swift)
target_sources(SwiftWin32 PRIVATE
  Sources/Support/Logging.swift
  Sources/Support/Range.swift
  Sources/Support/Rect+UIExtensions.swift
  Sources/Support/String.swift
  Sources/Support/WindowsHandle.swift
  Sources/Support/WinSDK+Extensions.swift)
target_compile_options(SwiftWin32 PRIVATE
  "SHELL:-Xcc -DNONAMELESSUNION"
  "SHELL:-Xcc -DCOBJMACROS")
target_link_libraries(SwiftWin32 PUBLIC User32 Gdi32 ComCtl32)
if(ENABLE_LOGGING)
  target_compile_definitions(SwiftWin32 PRIVATE
    ENABLE_LOGGING)
  if(TARGET SwiftLog::Logging)
    target_link_libraries(SwiftWin32 PUBLIC
      SwiftLog::Logging)
  endif()
endif()
set_target_properties(SwiftWin32 PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY}
  INTERFACE_LINK_DIRECTORIES $<TARGET_LINKER_FILE_DIR:SwiftWin32>)

add_executable(HelloSwift
  Examples/HelloSwift.swift)
add_custom_command(TARGET HelloSwift POST_BUILD
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Examples/$<TARGET_FILE_NAME:HelloSwift>.manifest $<TARGET_FILE_DIR:HelloSwift>)
target_link_libraries(HelloSwift PRIVATE SwiftWin32 Gdi32)

export(TARGETS SwiftWin32 FILE SwiftWin32Config.cmake)
