import 'package:flutter/material.dart';

class ConfirmWrapper extends StatefulWidget {
  final Widget Function(void Function() onTap) childBuilder;
  final String confirmationQuestionText;
  final String confirmationYesText;
  final String confirmationNoText;
  final void Function() onConfirm;
  final void Function()? onCancel;
  const ConfirmWrapper(
      {Key? key,
      required this.childBuilder,
      this.confirmationQuestionText = "Are you sure ?",
      this.confirmationYesText = "Yes",
      this.confirmationNoText = "No",
      required this.onConfirm,
      this.onCancel})
      : super(key: key);

  @override
  State<ConfirmWrapper> createState() => ConfirmWrapperState();
}

class ConfirmWrapperState extends State<ConfirmWrapper> {
  bool needsToConfirm = false;
  @override
  Widget build(BuildContext context) {
    if (needsToConfirm == false) {
      return InkWell(
          onTap: userNeedsToConfirm,
          child: widget.childBuilder(userNeedsToConfirm));
    } else {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Flexible(child: Text(widget.confirmationQuestionText)),
        TextButton(
            onPressed: userAccepted, child: Text(widget.confirmationYesText)),
        TextButton(
            onPressed: userCancelled, child: Text(widget.confirmationNoText)),
      ]);
    }
  }

  void userAccepted() {
    widget.onConfirm();
    setState(() {
      needsToConfirm = false;
    });
  }

  void userCancelled() {
    final onCancel = widget.onCancel;
    if (onCancel != null) {
      onCancel();
    }
    setState(() {
      needsToConfirm = false;
    });
  }

  void userNeedsToConfirm() {
    setState(() {
      needsToConfirm = true;
    });
  }
}
