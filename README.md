<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Useful Widgets and class extensions for Flutter apps

## Features

### Widgets

- `ConfirmWrapper` : Wrap any tappable widget with a graphical confirmation from the user. Useful for delete button, dangerous operations, etc.
- `DateTimeButton` : A button that allows the user to select a date (and optionnaly a time). The buttons displays the selected date.
- `EditableLabel` : A simple text with an edit button next to it. When clicked, a `TextField` allows to edit the value and save it.
- `NetworkOrFileImage` : A widgets that receives an image Uri and checks if it is a local image, an app asset or a network url. Then uses the correct API to fetch and display the image. For network images, it uses the [cached_network_image](https://pub.dev/packages/cached_network_image) library to download and cache the image before displaying it.

### Extensions :

- `Color` to hexadecimal : allows conversion from `Color` objects to a `String` Hexadecimal representation and also in reverse order (from `String` to `Color`)

## Getting started

Add the package as a dependency in your pubspec.yaml file

```yaml
dependencies:
  flutter:
    sdk: flutter

  directus_api_manager:
    git: https://github.com/maxbritto/extension_flutter_tools.git
```

## External contributions

If you want to add new widgets or extensions, please keep in mind before submitting a PR :

- Widgets and extensions must be generic enough to be usable in many projects
- Unit tests and automated tests are mandatory. 100% coverage is required for any newly added code

Thanks for your contributions!
Happy Coding.
Maxime
