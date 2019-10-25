cmake_minimum_required(VERSION 3.15.0)

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
  Sources/UI/View.swift
  Sources/UI/Window.swift
  Sources/UI/WindowClass.swift)
target_sources(SwiftWin32 PRIVATE
  Sources/CG/Point.swift
  Sources/CG/Rect.swift
  Sources/CG/Size.swift)
target_sources(SwiftWin32 PRIVATE
  Sources/Support/Rect+UIExtensions.swift
  Sources/Support/String.swift)
target_compile_options(SwiftWin32 PRIVATE
  -Xcc -DCOBJMACROS)
target_link_libraries(SwiftWin32 PUBLIC User32 Gdi32 ComCtl32)
set_target_properties(SwiftWin32 PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY}
  INTERFACE_LINK_DIRECTORIES $<TARGET_LINKER_FILE_DIR:SwiftWin32>)

add_executable(HelloSwift
  Sources/Examples/HelloSwift.swift)
target_link_libraries(HelloSwift PRIVATE SwiftWin32 Gdi32)

export(TARGETS SwiftWin32 FILE SwiftWin32Config.cmake)
