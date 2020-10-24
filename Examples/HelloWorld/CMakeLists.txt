add_executable(HelloWorld
  HelloWorld.swift)
add_custom_command(TARGET HelloWorld POST_BUILD
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist $<TARGET_FILE_DIR:HelloWorld>)
# FIXME(SR-12683) `@main` requires `-parse-as-library`
target_compile_options(HelloWorld PRIVATE
  -parse-as-library)
target_link_libraries(HelloWorld PRIVATE
  SwiftWin32)
