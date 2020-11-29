add_library(SwiftWin32UI SHARED
  EmptyView.swift
  Never+SwiftUI.swift
  SceneBuilder.swift
  View.swift
  ViewBuilder.swift)
target_sources(SwiftWin32UI PRIVATE
  Essentials/Application.swift
  Essentials/Scene.swift
  Essentials/WindowGroup.swift)
target_link_libraries(SwiftWin32UI PUBLIC
  SwiftWin32)
set_target_properties(SwiftWin32UI PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY}
  INTERFACE_LINK_DIRECTORIES $<TARGET_LINKER_FILE_DIR:SwiftWin32UI>)


swift_install(TARGETS SwiftWin32UI)
