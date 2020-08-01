add_executable(UICatalog
  UICatalog.swift)
add_custom_command(TARGET UICatalog POST_BUILD
  COMMAND
  ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/UICatalog.exe.manifest $<TARGET_FILE_DIR:UICatalog>)
# FIXME(SR-12683) `@main` requires `-parse-as-library`
target_compile_options(UICatalog PRIVATE
  -parse-as-library)
target_link_libraries(UICatalog PRIVATE
  $<$<VERSION_LESS:${CMAKE_Swift_COMPILER_VERSION},5.3>:Gdi32>
  SwiftWin32)
