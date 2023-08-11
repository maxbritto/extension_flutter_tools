import 'package:extension_flutter_tools/src/date_time_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group("DateTimeButton", () {
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
      await widgetTester.tap(find.byType(DateTimeButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text("OK"));

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
      await widgetTester.tap(find.byType(DateTimeButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text("OK"));
      await widgetTester.pumpAndSettle();
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
              mode: DateTimeButtonMode.date,
              onNewDateTimeSelected: (selectedDate) {})));
      await widgetTester.tap(find.byType(DateTimeButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text("OK"));
      await widgetTester.pumpAndSettle();
      expect(find.text("- - -"), findsNothing);
    });
  });
}
