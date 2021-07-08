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

file(GLOB LOGGING_SOURCES
     ${PROJECT_SOURCE_DIR}/Packages/swift-log/Sources/Logging/*.swift)
# FIXME(compnerd) 5.5 does not officially support static libraries on Windows
# either.  The support requires a version strictly greater than 5.5.  Once the
# branch is introduced, adjust this accordingly.
if(Swift_COMPILER_VERSION VERSION_LESS 5.5)
  add_library(Logging SHARED
    ${LOGGING_SOURCES})
  _install_target(Logging)
else()
  add_library(Logging STATIC
    ${LOGGING_SOURCES})
endif()

add_subdirectory(SwiftWin32)
add_subdirectory(SwiftWin32UI)
