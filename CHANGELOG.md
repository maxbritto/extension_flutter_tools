## 1.4.2

- DateTimeButton : Fixes a bug where the button was not working if we passed a minimum date in the future and no initial date.

## 1.4.1

- TestTools : added a `scrollUntilVisible` function to scroll a Scrollable view until a specific widget is visible. This function is useful to test widgets that are not visible on the screen by default.

## 1.4.0 

- DateTimeButton : allows a clear button to be displayed next to the date button. The clear button will clear the selected date and call the `onDateTimeCleared` callback. This button will only appear if the `onDateTimeCleared` callback is provided and a date is selected.
- Updated linting rules to be more strict : this may lead to new warnings if you forgot some const calls. Just add `const` where needed to remove the warnings and make your code more efficient.

## 1.3.0 

- DateTimeButton : allows passing a custom DateFormat object that will be used to display the selected date on the button. 

## 1.2.0 

- DateTimeButton : allows passing a null value to the onNewDateTimeSelected callback. When null is passed, the button will be disabled.

## 1.1.2

Dependencies :
- Allows intl 0.19.0

## 1.1.1

TestTools : 
- Added a pump call to the runTestableWidgetScreen function. This allows the launched screen to trigger an async call after being launched.

## 1.1.0

- Added an `ErrorView` component to display error messages.
- Added `TestTools` class with some static functions useful for unit tests for Flutter apps.

## 1.0.0

- Initial public version.
