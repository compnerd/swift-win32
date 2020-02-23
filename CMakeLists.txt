cmake_minimum_required(VERSION 3.16.0)

project(SwiftWin32 LANGUAGES Swift)

set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)

add_library(SwiftWin32 SHARED
  Sources/Application/Application.swift
  Sources/Application/ApplicationDelegate.swift
  Sources/Application/ApplicationMain.swift
  Sources/UI/Button.swift
  Sources/UI/Color.swift
  Sources/UI/Control.swift
  Sources/UI/EdgeInsets.swift
  Sources/UI/Label.swift
  Sources/UI/ProgressView.swift
  Sources/UI/Slider.swift
  Sources/UI/TextField.swift
  Sources/UI/TextView.swift
  Sources/UI/View.swift
  Sources/UI/Window.swift
  Sources/UI/WindowClass.swift)
target_sources(SwiftWin32 PRIVATE
  Sources/CG/Point.swift
  Sources/CG/Rect.swift
  Sources/CG/Size.swift)
target_sources(SwiftWin32 PRIVATE
  Sources/Support/Rect+UIExtensions.swift
  Sources/Support/String.swift
  Sources/Support/WinSDK+Extensions.swift)
target_compile_options(SwiftWin32 PRIVATE
  -Xcc -DCOBJMACROS)
target_link_libraries(SwiftWin32 PUBLIC User32 Gdi32 ComCtl32)
set_target_properties(SwiftWin32 PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY}
  INTERFACE_LINK_DIRECTORIES $<TARGET_LINKER_FILE_DIR:SwiftWin32>)

add_executable(HelloSwift
  Sources/Examples/HelloSwift.swift)
add_custom_command(TARGET HelloSwift POST_BUILD
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Sources/Examples/$<TARGET_FILE_NAME:HelloSwift>.manifest $<TARGET_FILE_DIR:HelloSwift>)
target_link_libraries(HelloSwift PRIVATE SwiftWin32 Gdi32)

export(TARGETS SwiftWin32 FILE SwiftWin32Config.cmake)
