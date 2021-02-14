add_executable(CustomPrincipalClass
  CustomPrincipalClass.swift MyApplication.swift)
add_custom_command(TARGET CustomPrincipalClass POST_BUILD
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/CustomPrincipalClass.exe.manifest $<TARGET_FILE_DIR:CustomPrincipalClass>
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist $<TARGET_FILE_DIR:CustomPrincipalClass>)
# FIXME(SR-12683) `@main` requires `-parse-as-library`
target_compile_options(CustomPrincipalClass PRIVATE
  -parse-as-library)
target_link_libraries(CustomPrincipalClass PRIVATE
  SwiftWin32)
