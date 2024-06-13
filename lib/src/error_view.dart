import 'package:flutter/material.dart';

class ErrorView extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? details;
  final Function? resolutionAction;
  final String? resolutionActionText;
  final Function? cancelAction;
  final String? cancelActionText;

  static const defaultActionButtonTitle = "Corriger le problème";
  static const defaultCancelActionTitle = "Annuler";

  const ErrorView(
      {super.key,
      required this.title,
      this.subtitle,
      this.details,
      this.resolutionAction,
      this.resolutionActionText,
      this.cancelAction,
      this.cancelActionText});

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final subtitle = widget.subtitle;
    final details = widget.details;
    final textTheme = Theme.of(context).textTheme;
    final resolutionAction = widget.resolutionAction;
    final cancelAction = widget.cancelAction;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(widget.title, style: textTheme.headlineSmall))
              ],
            ),
            const SizedBox(height: 8),
            if (subtitle != null)
              Text(subtitle,
                  style: textTheme.bodyLarge, textAlign: TextAlign.left),
            if (details != null ||
                resolutionAction != null ||
                cancelAction != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (cancelAction != null)
                    TextButton(
                        key: const Key("cancel-action-button"),
                        onPressed: () {
                          cancelAction();
                        },
                        child: Text(widget.cancelActionText ??
                            ErrorView.defaultCancelActionTitle)),
                  if (details != null)
                    Flexible(
                      child: TextButton.icon(
                          key: const Key("toggle-details-button"),
                          onPressed: toggleDetails,
                          icon: Icon(_isExpanded
                              ? Icons.expand_less
                              : Icons.expand_more),
                          label: Text(_isExpanded
                              ? "Masquer les détails"
                              : "Afficher les détails")),
                    ),
                  if (resolutionAction != null)
                    Flexible(
                      child: FilledButton(
                          key: const Key("fix-action-button"),
                          onPressed: () {
                            resolutionAction();
                          },
                          child: Text(widget.resolutionActionText ??
                              ErrorView.defaultActionButtonTitle)),
                    ),
                ],
              ),
            if (details != null && _isExpanded)
              Text(
                details,
                style: textTheme.labelSmall,
              ),
          ],
        ),
      ),
    );
  }

  void toggleDetails() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
