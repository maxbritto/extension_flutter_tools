import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateTimeButtonMode { date, dateAndTime }

class DateTimeButton extends StatefulWidget {
  final DateTime? initialDateTime;
  final DateTimeButtonMode mode;
  final DateTime? minAcceptedDate;
  final DateTime? maxAcceptedDate;

  /// Callback function that is called when a new date is selected and confirmed by the user
  /// The new date is passed as a parameter to the function
  /// If null, the button is disabled
  final void Function(DateTime newDateTime)? onNewDateTimeSelected;
  DateTimeButton(
      {Key? key,
      this.initialDateTime,
      this.minAcceptedDate,
      this.maxAcceptedDate,
      required this.onNewDateTimeSelected,
      this.mode = DateTimeButtonMode.dateAndTime})
      : super(key: key);

  @override
  State<DateTimeButton> createState() => _DateTimeButtonState();

  @visibleForTesting
  DateFormat get dateFormat {
    final DateFormat dateFormat = DateFormat.yMMMMd();
    if (mode == DateTimeButtonMode.dateAndTime) {
      return dateFormat.add_Hm();
    } else {
      return dateFormat;
    }
  }
}

class _DateTimeButtonState extends State<DateTimeButton> {
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    final onNewDateTimeSelected = widget.onNewDateTimeSelected;
    final displayedDate = selectedDateTime ?? widget.initialDateTime;
    final String displayedText = displayedDate == null
        ? "- - -"
        : widget.dateFormat.format(displayedDate);
    return OutlinedButton.icon(
        onPressed: onNewDateTimeSelected == null
            ? null
            : () async {
                final initialDateTime =
                    widget.initialDateTime ?? DateTime.now();
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: initialDateTime,
                    firstDate: widget.minAcceptedDate ?? DateTime(1900, 1, 1),
                    lastDate: widget.maxAcceptedDate ??
                        initialDateTime.add(Duration(days: 365)));
                if (widget.mode == DateTimeButtonMode.dateAndTime &&
                    newDate != null) {
                  final TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                        hour: initialDateTime.hour,
                        minute: initialDateTime.minute),
                    initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (newTime != null) {
                    newDate = DateTime(newDate.year, newDate.month, newDate.day,
                        newTime.hour, newTime.minute);
                  }
                }
                if (newDate != null) {
                  setState(() {
                    selectedDateTime = newDate;
                  });
                  onNewDateTimeSelected(newDate);
                }
              },
        icon: Icon(Icons.date_range),
        label: Text(displayedText));
  }
}
