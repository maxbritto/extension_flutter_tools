import 'package:flutter/material.dart';

class EditableLabel extends StatefulWidget {
  final String initialText;
  final Function(String) onTextChanged;
  final Function()? onEditingStarted;
  final Function()? onEditingFinished;
  const EditableLabel(
      {super.key,
      required this.initialText,
      required this.onTextChanged,
      this.onEditingStarted,
      this.onEditingFinished});

  @override
  State<EditableLabel> createState() => _EditableLabelState();
}

class _EditableLabelState extends State<EditableLabel> {
  bool _isEditing = false;
  String? newText;
  @override
  Widget build(BuildContext context) {
    if (_isEditing == false) {
      return Row(
        children: [
          Expanded(child: Text(newText ?? widget.initialText)),
          const SizedBox(width: 5),
          IconButton(onPressed: switchEditingMode, icon: const Icon(Icons.edit))
        ],
      );
    } else {
      return TextFormField(
        initialValue: widget.initialText,
        onFieldSubmitted: (value) {
          switchEditingMode();
        },
        onChanged: (value) {
          newText = value;
          widget.onTextChanged(value);
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
              color: Colors.green,
              onPressed: switchEditingMode,
              icon: const Icon(Icons.done)),
        ),
      );
    }
  }

  void switchEditingMode() {
    setState(() {
      if (_isEditing) {
        _isEditing = false;
        widget.onEditingFinished?.call();
      } else {
        _isEditing = true;
        widget.onEditingStarted?.call();
      }
    });
  }
}
