import 'package:flutter/material.dart';
import 'package:extension_flutter_tools/extension_flutter_tools.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Test HTML color conversion', () {
    expect("FF0000".asColor, const Color.fromARGB(255, 255, 0, 0));
    expect("00FF00".asColor, const Color.fromARGB(255, 0, 255, 0));
    expect("0000FF".asColor, const Color.fromARGB(255, 0, 0, 255));
  });

  test('Test HTML color conversion with leading #', () {
    expect("#FF0000".asColor, const Color.fromARGB(255, 255, 0, 0));
    expect("#00FF00".asColor, const Color.fromARGB(255, 0, 255, 0));
    expect("#0000FF".asColor, const Color.fromARGB(255, 0, 0, 255));
  });
}
