add_library(SwiftWin32 SHARED
  Application/_TriviallyConstructible.swift
  Application/Application.swift
  Application/ApplicationDelegate.swift
  Application/ApplicationMain.swift
  Application/Information.swift
  Application/LaunchKeyOptions.swift)
target_sources(SwiftWin32 PRIVATE
  AutoLayout/LayoutAnchor.swift
  AutoLayout/LayoutConstraint.swift
  AutoLayout/LayoutDimension.swift
  AutoLayout/LayoutGuide.swift
  AutoLayout/LayoutPriority.swift
  AutoLayout/LayoutSupport.swift
  AutoLayout/LayoutXAxisAnchor.swift
  AutoLayout/LayoutYAxisAnchor.swift)
target_sources(SwiftWin32 PRIVATE
  UI/Action.swift
  UI/AlertAction.swift
  UI/AlertController.swift
  UI/AnimationCurve.swift
  UI/BezierPath.swift
  UI/Button.swift
  UI/Color.swift
  UI/Command.swift
  UI/ContentContainer.swift
  UI/ContentSizeCategoryAdjusting.swift
  UI/ContentSizeCategoryImageAdjusting.swift
  UI/ContextMenuConfiguration.swift
  UI/ContextMenuInteraction.swift
  UI/ContextMenuInteractionAnimating.swift
  UI/ContextMenuInteractionCommitAnimating.swift
  UI/ContextMenuInteractionDelegate.swift
  UI/ContextualAction.swift
  UI/Control.swift
  UI/CoordinateSpace.swift
  UI/DatePicker.swift
  UI/Device.swift
  UI/EdgeInsets.swift
  UI/Event.swift
  UI/Font.swift
  UI/FontDescriptor.swift
  UI/FontMetrics.swift
  UI/Image.swift
  UI/ImageView.swift
  UI/Interaction.swift
  UI/Label.swift
  UI/Menu.swift
  UI/MenuBuilder.swift
  UI/MenuElement.swift
  UI/MenuSystem.swift
  UI/PreviewParameters.swift
  UI/PreviewTarget.swift
  UI/ProgressView.swift
  UI/Responder.swift
  UI/Scene.swift
  UI/SceneConfiguration.swift
  UI/SceneDelegate.swift
  UI/SceneSession.swift
  UI/SceneSizeRestrictions.swift
  UI/Screen.swift
  UI/Slider.swift
  UI/SpringLoadedInteractionContext.swift
  UI/Stepper.swift
  UI/SwipeActionsConfiguration.swift
  UI/Switch.swift
  UI/TableView.swift
  UI/TableViewCell.swift
  UI/TableViewDataSource.swift
  UI/TargetedPreview.swift
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
  CA/Transform3D.swift)
target_sources(SwiftWin32 PRIVATE
  CG/AffineTransform.swift
  CG/Point.swift
  CG/Rect.swift
  CG/Size.swift
  CG/Vector.swift)
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
  Support/Size+UIExtensions.swift
  Support/String+UIExtensions.swift
  Support/WindowsHandle+UIExtensions.swift
  Support/WinSDK+Extensions.swift)
target_compile_options(SwiftWin32 PRIVATE
  "SHELL:-Xfrontend -validate-tbd-against-ir=none")
target_link_libraries(SwiftWin32 PUBLIC
  ComCtl32
  User32)
target_link_libraries(SwiftWin32 PUBLIC
  SwiftCOM)
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
