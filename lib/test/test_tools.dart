import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestTools {
  static Future<String> loadStringFromFile(String filePath) async {
    if (filePath.startsWith('test_resources') == false) {
      filePath = 'test_resources/$filePath';
    }
    final file = File(filePath);
    return file.readAsString();
  }

  static Future<void> runTestableWidgetScreen(
      {required WidgetTester tester,
      Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
      Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
      Locale? locale,
      Widget? child}) async {
    HttpOverrides.global = null;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
      home: child,
    ));
  }

  static Future<void> runTestableComponent(
      {required WidgetTester tester,
      Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
      Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
      Locale? locale,
      required Widget child}) async {
    HttpOverrides.global = null;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
      home: Scaffold(body: SafeArea(child: child)),
    ));
  }

  static String generateLongString(int length, {String repeatingString = 'a'}) {
    final charCode = repeatingString.codeUnitAt(0);
    return String.fromCharCodes(Iterable.generate(length, (_) {
      return charCode;
    }));
  }
}
