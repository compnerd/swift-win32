add_executable(Notepad
  Notepad.swift)
add_custom_command(TARGET Notepad POST_BUILD
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist $<TARGET_FILE_DIR:Notepad>)
# FIXME(SR-12683) `@main` requires `-parse-as-library`
target_compile_options(Notepad PRIVATE
  -parse-as-library)
target_link_libraries(Notepad PRIVATE
  SwiftWin32)
