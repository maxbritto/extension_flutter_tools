import 'package:extension_flutter_tools/src/date_time_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DateTimeButton", () {
    Future<void> tapOnButtonThenPickDate(WidgetTester widgetTester,
        {String day = "28"}) async {
      await widgetTester.tap(find.byType(DateTimeButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text(day));
      await widgetTester.tap(find.text("OK"));
      await widgetTester.pumpAndSettle();
    }

    test("Display when mode is date and time", () {
      final dateTimeButton = DateTimeButton(
          initialDateTime: DateTime(2021, 1, 1, 12, 0),
          mode: DateTimeButtonMode.dateAndTime,
          onNewDateTimeSelected: (newDateTime) {});
      expect(dateTimeButton.dateFormat.dateOnly, false);
    });
    test("Display when mode is date only", () {
      final dateTimeButton = DateTimeButton(
          initialDateTime: DateTime(2021, 1, 1, 12, 0),
          onNewDateTimeSelected: (newDateTime) {},
          mode: DateTimeButtonMode.date);
      expect(dateTimeButton.dateFormat.dateOnly, true);
    });

    testWidgets("select a date and a time", (widgetTester) async {
      DateTime? newDateTime;
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              initialDateTime: DateTime(2021, 1, 1, 12, 0),
              mode: DateTimeButtonMode.dateAndTime,
              onNewDateTimeSelected: (selectedDate) {
                newDateTime = selectedDate;
              })));
      await tapOnButtonThenPickDate(widgetTester);

      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text("OK"));
      await widgetTester.pumpAndSettle();
      expect(newDateTime, isNotNull);
    });

    testWidgets("select a date only", (widgetTester) async {
      DateTime? newDateTime;
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              initialDateTime: DateTime(2021, 1, 1, 12, 0),
              mode: DateTimeButtonMode.date,
              onNewDateTimeSelected: (selectedDate) {
                newDateTime = selectedDate;
              })));
      await tapOnButtonThenPickDate(widgetTester);
      expect(newDateTime, isNotNull);
    });

    testWidgets("Display when intialDate is null and no date is selected",
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              mode: DateTimeButtonMode.date,
              onNewDateTimeSelected: (selectedDate) {})));
      expect(find.text("- - -"), findsOneWidget);
    });

    testWidgets("Display when intialDate is null and a date is selected",
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              initialDateTime: null,
              mode: DateTimeButtonMode.date,
              onNewDateTimeSelected: (selectedDate) {})));
      await tapOnButtonThenPickDate(widgetTester);
      expect(find.text("- - -"), findsNothing);
    });
    testWidgets("Display when intialDate is null and minDate is in the future",
        (widgetTester) async {
      final now = DateTime.now();
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              mode: DateTimeButtonMode.date,
              minAcceptedDate: now.add(const Duration(days: 1)),
              onNewDateTimeSelected: (selectedDate) {})));
      expect(find.text("- - -"), findsOneWidget);
      await widgetTester.tap(find.byType(DateTimeButton));
      await widgetTester.pumpAndSettle();
      expect(find.text("OK"), findsOneWidget,
          reason: "Button should be working");
    });
    testWidgets(
        "Add a clear button when a date is present and the clear callback function is provided",
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              initialDateTime: DateTime(2021, 1, 1, 12, 0),
              mode: DateTimeButtonMode.date,
              onNewDateTimeSelected: (selectedDate) {},
              onDateTimeCleared: () {})));
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });
    testWidgets(
        "Do not add a clear button when a date is present and the clear callback function is NOT provided",
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              initialDateTime: DateTime(2021, 1, 1, 12, 0),
              mode: DateTimeButtonMode.date,
              onNewDateTimeSelected: (selectedDate) {})));
      expect(find.byIcon(Icons.clear), findsNothing);
    });
    testWidgets("Tapping on the clear button when a date was present initially",
        (widgetTester) async {
      DateTime? newDateTime;
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              initialDateTime: DateTime(2021, 1, 1, 12, 0),
              mode: DateTimeButtonMode.date,
              onNewDateTimeSelected: (selectedDate) {
                newDateTime = selectedDate;
              },
              onDateTimeCleared: () {
                newDateTime = null;
              })));
      await widgetTester.tap(find.byIcon(Icons.clear));
      await widgetTester.pumpAndSettle();
      expect(newDateTime, isNull);
    });
    testWidgets(
        "Tapping on the clear button when NO date was present initially but the user had selected a date himself",
        (widgetTester) async {
      DateTime? newDateTime;
      await widgetTester.pumpWidget(MaterialApp(
          home: DateTimeButton(
              mode: DateTimeButtonMode.date,
              onNewDateTimeSelected: (selectedDate) {
                newDateTime = selectedDate;
              },
              onDateTimeCleared: () {
                newDateTime = null;
              })));
      await tapOnButtonThenPickDate(widgetTester);

      await widgetTester.tap(find.byIcon(Icons.clear));
      await widgetTester.pumpAndSettle();
      expect(newDateTime, isNull);
    });
  });
}
