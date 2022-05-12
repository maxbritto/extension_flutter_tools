import 'package:flutter/material.dart';

extension StringColors on String {
  Color? get asColor {
    try {
      final stringColor = replaceAll("#", "");
      final colorInt = int.parse(stringColor, radix: 16) + 0xff000000;
      return Color(colorInt);
    } catch (_) {
      return null;
    }
  }
}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true, bool includeAlpha = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
