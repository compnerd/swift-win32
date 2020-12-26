add_library(SwiftWin32 SHARED
  Application/_TriviallyConstructible.swift
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
  UI/AnimationCurve.swift
  UI/ContentSizeCategoryAdjusting.swift
  UI/ContentSizeCategoryImageAdjusting.swift
  UI/Interaction.swift
  UI/SceneSizeRestrictions.swift)
target_sources(SwiftWin32 PRIVATE
  "Animation and Haptics/View Controller Transitions/ViewControllerTransitionCoordinator.swift"
  "Animation and Haptics/View Controller Transitions/ViewControllerTransitionCoordinatorContext.swift")
target_sources(SwiftWin32 PRIVATE
  "App and Environment/Application.swift"
  "App and Environment/ApplicationDelegate.swift"
  "App and Environment/Device.swift"
  "App and Environment/TraitCollection.swift"
  "App and Environment/TraitEnvironment.swift")
target_sources(SwiftWin32 PRIVATE
  "App and Environment/Scenes/Scene.swift"
  "App and Environment/Scenes/SceneConfiguration.swift"
  "App and Environment/Scenes/SceneDelegate.swift"
  "App and Environment/Scenes/SceneSession.swift"
  "App and Environment/Scenes/WindowScene.swift"
  "App and Environment/Scenes/WindowSceneDelegate.swift")
target_sources(SwiftWin32 PRIVATE
  "Appearance Customization/Configurations/BackgroundConfiguration.swift"
  "Appearance Customization/Configurations/CellConfigurationState.swift"
  "Appearance Customization/Configurations/ConfigurationColorTransformer.swift"
  "Appearance Customization/Configurations/ConfigurationState.swift"
  "Appearance Customization/Configurations/ConfigurationStateCustomKey.swift")
target_sources(SwiftWin32 PRIVATE
  "Drag and Drop/SpringLoadedInteractionContext.swift")
target_sources(SwiftWin32 PRIVATE
  "Drawing/BezierPath.swift"
  "Drawing/Color.swift")
target_sources(SwiftWin32 PRIVATE
  "Focus-Based Navigation/FocusAnimationCoordinator.swift"
  "Focus-Based Navigation/FocusEnvironment.swift"
  "Focus-Based Navigation/FocusItem.swift"
  "Focus-Based Navigation/FocusItemContainer.swift"
  "Focus-Based Navigation/FocusMovementHint.swift"
  "Focus-Based Navigation/FocusUpdateContext.swift")
target_sources(SwiftWin32 PRIVATE
  "Images and PDF/Image.swift")
target_sources(SwiftWin32 PRIVATE
  "Keyboards and Input/TextInputTraits.swift")
target_sources(SwiftWin32 PRIVATE
  "Menus and Shortcuts/Action.swift"
  "Menus and Shortcuts/Command.swift"
  "Menus and Shortcuts/ContextMenuConfiguration.swift"
  "Menus and Shortcuts/ContextMenuInteractionAnimating.swift"
  "Menus and Shortcuts/ContextMenuInteractionCommitAnimating.swift"
  "Menus and Shortcuts/ContextMenuInteraction.swift"
  "Menus and Shortcuts/ContextMenuInteractionDelegate.swift"
  "Menus and Shortcuts/Menu.swift"
  "Menus and Shortcuts/MenuBuilder.swift"
  "Menus and Shortcuts/MenuElement.swift"
  "Menus and Shortcuts/MenuSystem.swift"
  "Menus and Shortcuts/PreviewParameters.swift"
  "Menus and Shortcuts/PreviewTarget.swift"
  "Menus and Shortcuts/TargetedPreview.swift")
target_sources(SwiftWin32 PRIVATE
  "Pointer Interactions/PointerInteraction.swift"
  "Pointer Interactions/PointerInteractionAnimating.swift"
  "Pointer Interactions/PointerInteractionDelegate.swift"
  "Pointer Interactions/PointerRegion.swift"
  "Pointer Interactions/PointerRegionRequest.swift"
  "Pointer Interactions/PointerStyle.swift")
target_sources(SwiftWin32 PRIVATE
  "Text Display and Fonts/Font.swift"
  "Text Display and Fonts/FontDescriptor.swift"
  "Text Display and Fonts/FontMetrics.swift")
target_sources(SwiftWin32 PRIVATE
  "Touches, Presses, and Gestures/Event.swift"
  "Touches, Presses, and Gestures/Responder.swift"
  "Touches, Presses, and Gestures/Touch.swift")
target_sources(SwiftWin32 PRIVATE
  "View Controllers/ContentContainer.swift"
  "View Controllers/ViewController.swift")
target_sources(SwiftWin32 PRIVATE
  "Views and Controls/Axis.swift"
  "Views and Controls/Button.swift"
  "Views and Controls/Control.swift"
  "Views and Controls/DatePicker.swift"
  "Views and Controls/DirectionalEdgeInsets.swift"
  "Views and Controls/DirectionalRectEdge.swift"
  "Views and Controls/EdgeInsets.swift"
  "Views and Controls/ImageView.swift"
  "Views and Controls/Label.swift"
  "Views and Controls/ProgressView.swift"
  "Views and Controls/Slider.swift"
  "Views and Controls/Stepper.swift"
  "Views and Controls/Switch.swift"
  "Views and Controls/TextField.swift"
  "Views and Controls/TextView.swift"
  "Views and Controls/View.swift"
  "Views and Controls/VisualEffect.swift")
target_sources(SwiftWin32 PRIVATE
  "Views and Controls/Table Views/ContextualAction.swift"
  "Views and Controls/Table Views/SwipeActionsConfiguration.swift"
  "Views and Controls/Table Views/TableView.swift"
  "Views and Controls/Table Views/TableViewCell.swift"
  "Views and Controls/Table Views/TableViewDataSource.swift"
  "Views and Controls/Table Views/TableViewDelegate.swift"
  "Views and Controls/Table Views/TableViewFocusUpdateContext.swift")
target_sources(SwiftWin32 PRIVATE
  "Windows and Screens/AlertAction.swift"
  "Windows and Screens/AlertController.swift"
  "Windows and Screens/CoordinateSpace.swift"
  "Windows and Screens/Screen.swift"
  "Windows and Screens/Window.swift")
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
