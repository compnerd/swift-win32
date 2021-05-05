add_executable(UICatalog
  UICatalog.swift)
add_custom_command(TARGET UICatalog POST_BUILD
  COMMAND
    mt -nologo -manifest ${CMAKE_CURRENT_SOURCE_DIR}/UICatalog.exe.manifest -outputresource:$<TARGET_FILE:UICatalog>
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist $<TARGET_FILE_DIR:UICatalog>
  COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Assets/CoffeeCup.jpg $<TARGET_FILE_DIR:UICatalog>)
# FIXME(SR-12683) `@main` requires `-parse-as-library`
target_compile_options(UICatalog PRIVATE
  -parse-as-library)
target_link_libraries(UICatalog PRIVATE
  SwiftWin32)
