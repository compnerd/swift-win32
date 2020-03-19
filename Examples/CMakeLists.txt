add_executable(HelloSwift
  HelloSwift.swift)
add_custom_command(TARGET HelloSwift POST_BUILD
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/$<TARGET_FILE_NAME:HelloSwift>.manifest $<TARGET_FILE_DIR:HelloSwift>)
target_link_libraries(HelloSwift PRIVATE
  Gdi32
  SwiftWin32)
