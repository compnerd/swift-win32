add_subdirectory(CWinRT)

add_library(SwiftWin32 SHARED
  Application/Application.swift
  Application/ApplicationDelegate.swift
  Application/ApplicationMain.swift)
target_sources(SwiftWin32 PRIVATE
  UI/AlertAction.swift
  UI/AlertController.swift
  UI/AnimationCurve.swift
  UI/Button.swift
  UI/Color.swift
  UI/ContentContainer.swift
  UI/Control.swift
  UI/DatePicker.swift
  UI/Device.swift
  UI/EdgeInsets.swift
  UI/Font.swift
  UI/Label.swift
  UI/ProgressView.swift
  UI/Screen.swift
  UI/Slider.swift
  UI/Stepper.swift
  UI/Switch.swift
  UI/TextField.swift
  UI/TextInputTraits.swift
  UI/TextView.swift
  UI/TraitCollection.swift
  UI/TraitEnvironment.swift
  UI/View.swift
  UI/ViewController.swift
  UI/ViewControllerTransitionCoordinator.swift
  UI/ViewControllerTransitionCoordinatorContext.swift
  UI/Window.swift)
target_sources(SwiftWin32 PRIVATE
  CG/AffineTransform.swift
  CG/Point.swift
  CG/Rect.swift
  CG/Size.swift)
target_sources(SwiftWin32 PRIVATE
  Support/BatteryMonitor.swift
  Support/Error.swift
  Support/Logging.swift
  Support/Rect+UIExtensions.swift
  Support/PropertyWrappers.swift
  Support/String.swift
  Support/WindowClass.swift
  Support/WindowsHandle.swift
  Support/WinSDK+Extensions.swift)
target_compile_options(SwiftWin32 PRIVATE
  "SHELL:-Xcc -DNONAMELESSUNION"
  "SHELL:-Xcc -DCOBJMACROS")
target_link_libraries(SwiftWin32 PUBLIC
  $<$<VERSION_LESS:${CMAKE_Swift_COMPILER_VERSION},5.3>:Gdi32>
  ComCtl32
  User32)
target_link_libraries(SwiftWin32 PUBLIC
  $<$<NOT:$<PLATFORM_ID:Darwin>>:dispatch>
  $<$<NOT:$<PLATFORM_ID:Darwin>>:Foundation>)
if(WITH_SWIFT_LOG)
  target_compile_definitions(SwiftWin32 PRIVATE
    WITH_SWIFT_LOG)
  if(TARGET SwiftLog::Logging)
    target_link_libraries(SwiftWin32 PUBLIC
      SwiftLog::Logging)
  endif()
endif()
set_target_properties(SwiftWin32 PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY}
  INTERFACE_LINK_DIRECTORIES $<TARGET_LINKER_FILE_DIR:SwiftWin32>)


swift_install(TARGETS SwiftWin32)
