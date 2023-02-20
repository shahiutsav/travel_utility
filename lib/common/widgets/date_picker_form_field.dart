import 'package:flutter/material.dart';

class DatePickerFormField extends StatefulWidget {
  final String labelText;
  final Function(DateTime) onDateSelected;
  const DatePickerFormField({
    super.key,
    required this.labelText,
    required this.onDateSelected,
  });

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.onDateSelected(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${selectedDate.toLocal()}'.split(' ')[0]),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
