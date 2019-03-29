cmake_minimum_required(VERSION 3.14)

project(SwiftWin32 LANGUAGES Swift)

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

add_executable(HelloSwift
  Sources/Examples/HelloSwift.swift)
target_compile_options(HelloSwift PRIVATE -I${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries(HelloSwift PRIVATE SwiftWin32 Gdi32)

