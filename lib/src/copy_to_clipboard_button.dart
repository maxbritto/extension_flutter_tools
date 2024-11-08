import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipboardButton extends StatefulWidget {
  final String copyableText;
  final String uncopiedTitle;
  final String copiedTitle;
  const CopyToClipboardButton(
      {super.key,
      required this.copyableText,
      this.uncopiedTitle = "Copy to Clipboard",
      this.copiedTitle = "Copied!"});

  @override
  State<CopyToClipboardButton> createState() => _CopyToClipboardButtonState();
}

class _CopyToClipboardButtonState extends State<CopyToClipboardButton> {
  bool _isCopied = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton.icon(
          key: const Key('copy_to_clipboard_button'),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: widget.copyableText));
            _toggleCopied();
            Timer(const Duration(seconds: 2), () {
              _toggleCopied();
            });
          },
          label: Text(_isCopied ? widget.copiedTitle : widget.uncopiedTitle),
          icon: Icon(_isCopied ? Icons.check : Icons.content_copy),
        ),
      ],
    );
  }

  _toggleCopied() {
    setState(() {
      _isCopied = !_isCopied;
    });
  }
}
