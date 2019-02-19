cmake_minimum_required(VERSION 3.14)

project(SwiftWin32 LANGUAGES Swift)

add_library(SwiftWin32 SHARED
  Window.swift
  WindowClass.swift
  WindowDelegate.swift)
target_link_libraries(SwiftWin32 PUBLIC User32)

add_executable(HelloSwift
  HelloSwift.swift)
target_compile_options(HelloSwift PRIVATE -I${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries(HelloSwift PRIVATE SwiftWin32)

