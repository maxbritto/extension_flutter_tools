import 'package:extension_flutter_tools/src/copy_to_clipboard_button.dart';
import 'package:extension_flutter_tools/test/test_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(CopyToClipboardButton, () {
    testWidgets('copy to clipboard button ...', (tester) async {
      await TestTools.runTestableComponent(
          tester: tester,
          child: const CopyToClipboardButton(
            copyableText: 'copyable text',
          ));
      expect(find.text('Copy to Clipboard'), findsOneWidget,
          reason: "initial default title");
      expect(find.byIcon(Icons.content_copy), findsOneWidget,
          reason: "initial default icon");
      await tester.tap(find.byKey(const Key('copy_to_clipboard_button')));
      await tester.pump();
      expect(find.text('Copied!'), findsOneWidget, reason: "after tap title");
      expect(find.byIcon(Icons.check), findsOneWidget,
          reason: "after tap icon");
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Copy to Clipboard'), findsOneWidget,
          reason: "after 2 seconds shold have reverted back to initial title");
      expect(find.byIcon(Icons.content_copy), findsOneWidget,
          reason: "after 2 seconds shold have reverted back to initial icon");
    });

    testWidgets('copy to clipboard button with custom titles ...',
        (tester) async {
      await TestTools.runTestableComponent(
          tester: tester,
          child: const CopyToClipboardButton(
            copyableText: 'copyable text',
            uncopiedTitle: 'Copy',
            copiedTitle: 'Copied',
          ));
      expect(find.text('Copy'), findsOneWidget, reason: "initial custom title");
      expect(find.byIcon(Icons.content_copy), findsOneWidget,
          reason: "initial custom icon");
      await tester.tap(find.byKey(const Key('copy_to_clipboard_button')));
      await tester.pump();
      expect(find.text('Copied'), findsOneWidget,
          reason: "after tap custom title");
      expect(find.byIcon(Icons.check), findsOneWidget,
          reason: "after tap custom icon");
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Copy'), findsOneWidget,
          reason:
              "after 2 seconds shold have reverted back to initial custom title");
    });
  });
}
