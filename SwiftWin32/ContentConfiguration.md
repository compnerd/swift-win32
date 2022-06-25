---
layout: default
title: ContentConfiguration
parent: SwiftWin32
---
# ContentConfiguration

The requirements for an object that provides the configuration for a content
view.

``` swift
public protocol ContentConfiguration 
```

## Requirements

### makeContentView()

Creates a new instance of the content view using this configuration.

``` swift
func makeContentView() -> View & ContentView
```

### updated(for:​)

Generates a configuration for the specified state by applying the
configuration's default values for that state to any properties that you
haven't customized.

``` swift
func updated(for state: ConfigurationState) -> Self
```
