#[[
Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
All rights reserved.

SPDX-License-Identifier: BSD-3-Clause
#]]

# NOTE(compnerd) because these modules are meant to be static and pristine,
# there can be no changes to the sources here.  As such, these modules are safe
# to glob because they cannot impact the build.

file(GLOB CASSOWARY_SOURCES
     ${PROJECT_SOURCE_DIR}/Packages/cassowary/Sources/Cassowary/*.swift)
add_library(Cassowary SHARED
  ${CASSOWARY_SOURCES})
set_target_properties(Cassowary PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
_install_target(Cassowary)

file(GLOB_RECURSE COM_SOURCES
     ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/*.swift
     ${PROJECT_SOURCE_DIR}/Packages/SwiftCOM/Sources/SwiftCOM/**/*.swift)
add_library(SwiftCOM SHARED
  ${COM_SOURCES})
target_link_libraries(SwiftCOM PUBLIC
  Ole32
  PortableDeviceGUIDs)
set_target_properties(SwiftCOM PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
_install_target(SwiftCOM)

add_subdirectory(SwiftWin32)
add_subdirectory(SwiftWin32UI)
