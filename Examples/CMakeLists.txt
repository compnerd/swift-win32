add_executable(HelloSwift
  HelloSwift.swift)
add_custom_command(TARGET HelloSwift POST_BUILD
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/$<TARGET_FILE_NAME:HelloSwift>.manifest $<TARGET_FILE_DIR:HelloSwift>)
# FIXME(SR-12683) `@main` requires `-parse-as-library`
target_compile_options(HelloSwift PRIVATE
  -parse-as-library)
target_link_libraries(HelloSwift PRIVATE
  $<$<VERSION_LESS:${CMAKE_Swift_COMPILER_VERSION},5.3>:Gdi32>
  SwiftWin32)
