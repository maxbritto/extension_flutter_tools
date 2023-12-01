import 'package:extension_flutter_tools/extension_flutter_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ErrorView", () {
    testWidgets("With only title", (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester, child: const ErrorView(title: "Error Title"));
      expect(find.text("Error Title"), findsOneWidget);
    });

    testWidgets("With title and subtitle", (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester,
          child: const ErrorView(
              title: "Error Title", subtitle: "Error subtitle"));
      expect(find.text("Error Title"), findsOneWidget);
      expect(find.text("Error subtitle"), findsOneWidget);
    });

    testWidgets("With title, subtitle and details", (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester,
          child: const ErrorView(
              title: "Error Title",
              subtitle: "Error subtitle",
              details: "Error details"));
      expect(find.text("Error Title"), findsOneWidget);
      expect(find.text("Error subtitle"), findsOneWidget);
      expect(find.text("Error details"), findsNothing, reason: "Collapsed");
      expect(find.byIcon(Icons.expand_more), findsOneWidget);

      await widgetTester.tap(find.byIcon(Icons.expand_more));
      await widgetTester.pumpAndSettle();

      expect(find.text("Error details"), findsOneWidget);
      expect(find.byIcon(Icons.expand_less), findsOneWidget);

      await widgetTester.tap(find.byIcon(Icons.expand_less));
      await widgetTester.pumpAndSettle();

      expect(find.text("Error details"), findsNothing, reason: "Collapsed");
    });

    testWidgets("With title, subtitle and a resolution action provided",
        (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester,
          child: ErrorView(
              title: "Error Title",
              subtitle: "Error subtitle",
              details: "Error details",
              resolutionAction: () {},
              resolutionActionText: "Fix this"));
      expect(find.text("Fix this"), findsOneWidget);
      expect(find.byKey(const Key("fix-action-button")), findsOneWidget);
    });

    testWidgets(
        "With title, subtitle and a resolution action provided but not action text",
        (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester,
          child: ErrorView(
              title: "Error Title",
              subtitle: "Error subtitle",
              details: "Error details",
              resolutionAction: () {}));
      expect(find.text(ErrorView.defaultActionButtonTitle), findsOneWidget);
      expect(find.byKey(const Key("fix-action-button")), findsOneWidget);
    });

    testWidgets("With title, subtitle and a cancel action provided",
        (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester,
          child: ErrorView(
              title: "Error Title",
              subtitle: "Error subtitle",
              details: "Error details",
              cancelAction: () {},
              cancelActionText: "Cancel"));

      expect(find.text("Cancel"), findsOneWidget);
      expect(find.byKey(const Key("cancel-action-button")), findsOneWidget);
    });

    testWidgets(
        "With title, subtitle and a cancel action provided but not cancel text",
        (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester,
          child: ErrorView(
              title: "Error Title",
              subtitle: "Error subtitle",
              details: "Error details",
              cancelAction: () {}));

      expect(find.text(ErrorView.defaultCancelActionTitle), findsOneWidget);
      expect(find.byKey(const Key("cancel-action-button")), findsOneWidget);
    });

    testWidgets("With title, subtitle and both actions provided",
        (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester,
          child: ErrorView(
              title: "Error Title",
              subtitle: "Error subtitle",
              details: "Error details",
              resolutionAction: () {},
              resolutionActionText: "Fix this",
              cancelAction: () {},
              cancelActionText: "Cancel"));

      expect(find.text("Fix this"), findsOneWidget);
      expect(find.byKey(const Key("fix-action-button")), findsOneWidget);
      expect(find.text("Cancel"), findsOneWidget);
      expect(find.byKey(const Key("cancel-action-button")), findsOneWidget);
    });
    testWidgets("With title, subtitle and both actions provided and no details",
        (widgetTester) async {
      await TestTools.runTestableComponent(
          tester: widgetTester,
          child: ErrorView(
              title: "Error Title",
              subtitle: "Error subtitle",
              resolutionAction: () {},
              resolutionActionText: "Fix this",
              cancelAction: () {},
              cancelActionText: "Cancel"));

      expect(find.text("Fix this"), findsOneWidget);
      expect(find.byKey(const Key("fix-action-button")), findsOneWidget);
      expect(find.text("Cancel"), findsOneWidget);
      expect(find.byKey(const Key("cancel-action-button")), findsOneWidget);
      expect(find.byKey(const Key("toggle-details-button")), findsNothing);
    });
  });
}
