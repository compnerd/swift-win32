#[[
Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
All rights reserved.

SPDX-License-Identifier: BSD-3-Clause
#]]

cmake_minimum_required(VERSION 3.16.0)

project(SwiftWin32
  LANGUAGES C CXX Swift)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/Modules)

option(WITH_SWIFT_LOG "Enable logging through swift-log" NO)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)

if(WITH_SWIFT_LOG)
  find_package(swift-log CONFIG QUIET)
endif()
find_package(dispatch CONFIG QUIET)
find_package(Foundation CONFIG QUIET)

find_package(Git REQUIRED)
execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                RESULT_VARIABLE GIT_SUBMODULE_UPDATE_RESULT)
if(NOT GIT_SUBMODULE_UPDATE_RESULT EQUAL "0")
  message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMODULE_UPDATE_RESULT}, please checkout submodules")
endif()

execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/Packages/Cassowary"
  OUTPUT_VARIABLE CASSOWARY_GIT_REVISION
  ERROR_QUIET
  OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/Packages/SwiftCOM"
  OUTPUT_VARIABLE SWIFT_COM_GIT_REVISION
  ERROR_QUIET
  OUTPUT_STRIP_TRAILING_WHITESPACE)

include(SwiftSupport)

add_subdirectory(Sources)
add_subdirectory(Examples)

message("-- Building with sub-modules:")
message("--   Cassowary rG${CASSOWARY_GIT_REVISION}")
message("--   Swift/COM rG${SWIFT_COM_GIT_REVISION}")
export(TARGETS SwiftCOM SwiftWin32
  FILE SwiftWin32Config.cmake)
