add_library(SwiftWin32 SHARED
  Application/_TriviallyConstructible.swift
  Application/Application.swift
  Application/ApplicationDelegate.swift
  Application/ApplicationMain.swift
  Application/Information.swift
  Application/LaunchKeyOptions.swift)
target_sources(SwiftWin32 PRIVATE
  UI/AlertAction.swift
  UI/AlertController.swift
  UI/AnimationCurve.swift
  UI/Button.swift
  UI/Color.swift
  UI/ContentContainer.swift
  UI/ContentsizeCategoryAdjusting.swift
  UI/Control.swift
  UI/CoordinateSpace.swift
  UI/DatePicker.swift
  UI/Device.swift
  UI/EdgeInsets.swift
  UI/Event.swift
  UI/Font.swift
  UI/FontDescriptor.swift
  UI/FontMetrics.swift
  UI/Label.swift
  UI/ProgressView.swift
  UI/Responder.swift
  UI/Scene.swift
  UI/SceneConfiguration.swift
  UI/SceneDelegate.swift
  UI/SceneSession.swift
  UI/SceneSizeRestrictions.swift
  UI/Screen.swift
  UI/Slider.swift
  UI/Stepper.swift
  UI/Switch.swift
  UI/TableView.swift
  UI/TableViewCell.swift
  UI/TableViewDataSource.swift
  UI/TextField.swift
  UI/TextInputTraits.swift
  UI/TextView.swift
  UI/Touch.swift
  UI/TraitCollection.swift
  UI/TraitEnvironment.swift
  UI/View.swift
  UI/ViewController.swift
  UI/ViewControllerTransitionCoordinator.swift
  UI/ViewControllerTransitionCoordinatorContext.swift
  UI/Window.swift
  UI/WindowScene.swift)
target_sources(SwiftWin32 PRIVATE
  CG/AffineTransform.swift
  CG/Point.swift
  CG/Rect.swift
  CG/Size.swift)
target_sources(SwiftWin32 PRIVATE
  Platform/BatteryMonitor.swift
  Platform/Error.swift
  Platform/PropertyWrappers.swift
  Platform/WindowClass.swift
  Platform/WindowsHandle.swift)
target_sources(SwiftWin32 PRIVATE
  Support/IndexPath+UIExtensions.swift
  Support/Logging.swift
  Support/Rect+UIExtensions.swift
  Support/Point+UIExtensions.swift
  Support/String+UIExtensions.swift
  Support/WindowsHandle+UIExtensions.swift
  Support/WinSDK+Extensions.swift)
target_compile_options(SwiftWin32 PRIVATE
  "SHELL:-Xfrontend -validate-tbd-against-ir=none")
target_link_libraries(SwiftWin32 PUBLIC
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
