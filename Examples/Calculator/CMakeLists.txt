add_executable(Calculator
  Calculator.swift)
add_custom_command(TARGET Calculator POST_BUILD
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Calculator.exe.manifest $<TARGET_FILE_DIR:Calculator>)
# FIXME(SR-12683) `@main` requires `-parse-as-library`
target_compile_options(Calculator PRIVATE
  -parse-as-library)
target_link_libraries(Calculator PRIVATE
  SwiftWin32)
