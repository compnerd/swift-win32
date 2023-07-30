#[[
Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
All rights reserved.

SPDX-License-Identifier: BSD-3-Clause
#]]

add_library(SwiftWin32 SHARED
  Application/_TriviallyConstructible.swift
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
  UI/ContentSizeCategoryAdjusting.swift
  UI/ContentSizeCategoryImageAdjusting.swift
  UI/Interaction.swift
  UI/SceneSizeRestrictions.swift)
target_sources(SwiftWin32 PRIVATE
  "App Extensions/InputViewController.swift"
  "Animation and Haptics/ViewControllerContextTransitioning.swift"
  "Animation and Haptics/Property-Based Animations/CubicTimingParameters.swift"
  "Animation and Haptics/Property-Based Animations/SpringTimingParameters.swift"
  "Animation and Haptics/Property-Based Animations/TimingCurveProvider.swift"
  "Animation and Haptics/Property-Based Animations/ViewAnimating.swift"
  "Animation and Haptics/Property-Based Animations/ViewImplicitlyAnimating.swift"
  "Animation and Haptics/View Controller Transitions/ViewControllerAnimatedTransitioning.swift"
  "Animation and Haptics/View Controller Transitions/ViewControllerInteractiveTransitioning.swift"
  "Animation and Haptics/View Controller Transitions/ViewControllerTransitionCoordinator.swift"
  "Animation and Haptics/View Controller Transitions/ViewControllerTransitionCoordinatorContext.swift"
  "Animation and Haptics/View Controller Transitions/ViewControllerTransitioningDelegate.swift"
  "App and Environment/AdaptivePresentationControllerDelegate.swift"
  "App and Environment/Application.swift"
  "App and Environment/ApplicationDelegate.swift"
  "App and Environment/ApplicationMain.swift"
  "App and Environment/Device.swift"
  "App and Environment/TraitCollection.swift"
  "App and Environment/TraitEnvironment.swift"
  "App and Environment/Scenes/Scene.swift"
  "App and Environment/Scenes/SceneConfiguration.swift"
  "App and Environment/Scenes/SceneDelegate.swift"
  "App and Environment/Scenes/SceneSession.swift"
  "App and Environment/Scenes/WindowScene.swift"
  "App and Environment/Scenes/WindowSceneDelegate.swift"
  "Appearance Customization/Configurations/BackgroundConfiguration.swift"
  "Appearance Customization/Configurations/CellConfigurationState.swift"
  "Appearance Customization/Configurations/ConfigurationColorTransformer.swift"
  "Appearance Customization/Configurations/ConfigurationState.swift"
  "Appearance Customization/Configurations/ConfigurationStateCustomKey.swift"
  "Drag and Drop/SpringLoadedInteractionContext.swift"
  "Drawing/BezierPath.swift"
  "Drawing/Color.swift"
  "Focus-Based Navigation/FocusAnimationCoordinator.swift"
  "Focus-Based Navigation/FocusEnvironment.swift"
  "Focus-Based Navigation/FocusItem.swift"
  "Focus-Based Navigation/FocusItemContainer.swift"
  "Focus-Based Navigation/FocusMovementHint.swift"
  "Focus-Based Navigation/FocusUpdateContext.swift"
  "Images and PDF/Image.swift"
  "Keyboards and Input/TextInputTraits.swift"
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
  "Menus and Shortcuts/TargetedPreview.swift"
  "Pointer Interactions/PointerInteraction.swift"
  "Pointer Interactions/PointerInteractionAnimating.swift"
  "Pointer Interactions/PointerInteractionDelegate.swift"
  "Pointer Interactions/PointerRegion.swift"
  "Pointer Interactions/PointerRegionRequest.swift"
  "Pointer Interactions/PointerStyle.swift"
  "Text Display and Fonts/Font.swift"
  "Text Display and Fonts/FontDescriptor.swift"
  "Text Display and Fonts/FontMetrics.swift"
  "Touches, Presses, and Gestures/Event.swift"
  "Touches, Presses, and Gestures/GestureRecognizer.swift"
  "Touches, Presses, and Gestures/GestureRecognizerDelegate.swift"
  "Touches, Presses, and Gestures/Responder.swift"
  "Touches, Presses, and Gestures/Touch.swift"
  "Touches, Presses, and Gestures/Press.swift"
  "Touches, Presses, and Gestures/PressesEvent.swift"
  "View Controllers/ContentContainer.swift"
  "View Controllers/PresentationController.swift"
  "View Controllers/ViewController.swift"
  "Views and Controls/Axis.swift"
  "Views and Controls/BarItem.swift"
  "Views and Controls/BarButtonItem.swift"
  "Views and Controls/BarButtonItemGroup.swift"
  "Views and Controls/BarPositioning.swift"
  "Views and Controls/Button.swift"
  "Views and Controls/Control.swift"
  "Views and Controls/DatePicker.swift"
  "Views and Controls/DirectionalEdgeInsets.swift"
  "Views and Controls/DirectionalRectEdge.swift"
  "Views and Controls/EdgeInsets.swift"
  "Views and Controls/ImageView.swift"
  "Views and Controls/Label.swift"
  "Views and Controls/Offset.swift"
  "Views and Controls/PickerView.swift"
  "Views and Controls/ProgressView.swift"
  "Views and Controls/Slider.swift"
  "Views and Controls/Stepper.swift"
  "Views and Controls/Switch.swift"
  "Views and Controls/TextField.swift"
  "Views and Controls/TextView.swift"
  "Views and Controls/View.swift"
  "Views and Controls/VisualEffect.swift"
  "Views and Controls/Table Views/ContextualAction.swift"
  "Views and Controls/Table Views/SwipeActionsConfiguration.swift"
  "Views and Controls/Table Views/TableView.swift"
  "Views and Controls/Table Views/TableViewCell.swift"
  "Views and Controls/Table Views/TableViewDataSource.swift"
  "Views and Controls/Table Views/TableViewDelegate.swift"
  "Views and Controls/Table Views/TableViewFocusUpdateContext.swift"
  "Windows and Screens/AlertAction.swift"
  "Windows and Screens/AlertController.swift"
  "Windows and Screens/CoordinateSpace.swift"
  "Windows and Screens/Screen.swift"
  "Windows and Screens/Window.swift")
target_sources(SwiftWin32 PRIVATE
  CG/AffineTransform.swift
  CG/Point.swift
  CG/Rect.swift
  CG/Size.swift
  CG/Vector.swift)
target_sources(SwiftWin32 PRIVATE
  Platform/BatteryMonitor.swift
  Platform/Error.swift
  Platform/Win32+Menu.swift
  Platform/Win32+PropertyWrappers.swift
  Platform/WindowClass.swift
  Platform/WindowsHandle.swift)
target_sources(SwiftWin32 PRIVATE
  Support/Array+Extensions.swift
  Support/Date+Extensions.swift
  Support/IndexPath+UIExtensions.swift
  Support/Logging.swift
  Support/Rect+UIExtensions.swift
  Support/Point+UIExtensions.swift
  Support/Size+UIExtensions.swift
  Support/String+UIExtensions.swift
  Support/WindowsHandle+UIExtensions.swift
  Support/WinSDK+Extensions.swift
  Support/WinSDK+UIExtensions.swift)
target_sources(SwiftWin32 PRIVATE
  Support/WindowMessage.swift)
if(CMAKE_Swift_COMPILER_VERSION VERSION_LESS 5.7.0)
  target_sources(SwiftWin32 PRIVATE
    CoreAnimation/Transform3D.swift)
else()
  add_library(CoreAnimation STATIC
    CoreAnimation/Transform3D.swift)
  target_link_libraries(SwiftWin32 PRIVATE
    CoreAnimation)
endif()
target_link_libraries(SwiftWin32 PUBLIC
  ComCtl32
  User32)
target_link_libraries(SwiftWin32 PUBLIC
  SwiftCOM)
target_link_libraries(SwiftWin32 PUBLIC
  $<$<NOT:$<PLATFORM_ID:Darwin>>:dispatch>
  $<$<NOT:$<PLATFORM_ID:Darwin>>:Foundation>)
target_link_libraries(SwiftWin32 PRIVATE
  Logging
  OrderedCollections)
set_target_properties(SwiftWin32 PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY}
  INTERFACE_LINK_DIRECTORIES $<TARGET_LINKER_FILE_DIR:SwiftWin32>)


if(CMAKE_Swift_COMPILER_VERSION VERSION_GREATER_EQUAL 5.7.0)
  _install_target(CoreAnimation)
endif()
_install_target(SwiftWin32)
