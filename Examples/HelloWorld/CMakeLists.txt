add_executable(HelloWorld
  HelloWorld.swift)
# FIXME(SR-12683) `@main` requires `-parse-as-library`
target_compile_options(HelloWorld PRIVATE
  -parse-as-library)
target_link_libraries(HelloWorld PRIVATE
  SwiftWin32)
