cmake_minimum_required(VERSION 3.14.20190522)

project(SwiftWin32 LANGUAGES Swift)

set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)

add_library(SwiftWin32 SHARED
  Sources/Application/Application.swift
  Sources/Application/ApplicationDelegate.swift
  Sources/Application/ApplicationMain.swift
  Sources/UI/Color.swift
  Sources/UI/Window.swift
  Sources/UI/WindowClass.swift
  Sources/UI/WindowDelegate.swift)
target_sources(SwiftWin32 PRIVATE
  Sources/CG/Point.swift
  Sources/CG/Rect.swift
  Sources/CG/Size.swift)
target_sources(SwiftWin32 PRIVATE
  Sources/Support/String.swift)
target_link_libraries(SwiftWin32 PUBLIC User32)
set_target_properties(SwiftWin32 PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_BINARY_DIR}/swift
  INTERFACE_LINK_DIRECTORIES $<TARGET_LINKER_FILE_DIR:SwiftWin32>)

add_executable(HelloSwift
  Sources/Examples/HelloSwift.swift)
target_link_libraries(HelloSwift PRIVATE SwiftWin32 Gdi32)

