import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeButton extends StatelessWidget {
  final DateTime initialDateTime;
  final void Function(DateTime newDateTime) onNewDateTimeSelected;
  const DateTimeButton(
      {Key? key,
      required this.initialDateTime,
      required this.onNewDateTimeSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: initialDateTime,
              firstDate: initialDateTime.add(Duration(days: -800)),
              lastDate: initialDateTime.add(Duration(days: 800)));
          if (newDate != null) {
            final TimeOfDay? newTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                  hour: initialDateTime.hour, minute: initialDateTime.minute),
              initialEntryMode: TimePickerEntryMode.input,
            );
            if (newTime != null) {
              newDate = DateTime(newDate.year, newDate.month, newDate.day,
                  newTime.hour, newTime.minute);
            }
            onNewDateTimeSelected(newDate);
          }
        },
        icon: Icon(Icons.date_range),
        label: Text(DateFormat.MMMEd().add_Hm().format(initialDateTime)));
  }
}
