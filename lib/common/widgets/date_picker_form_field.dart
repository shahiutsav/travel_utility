import 'package:flutter/material.dart';

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField({
    super.key,
    required this.labelText,
    required this.selectedDate,
  });

  final String labelText;
  final ValueNotifier<DateTime> selectedDate;

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.selectedDate.addListener(_updateSelectedDate);
  }

  @override
  void dispose() {
    widget.selectedDate.removeListener(_updateSelectedDate);
    super.dispose();
  }

  void _updateSelectedDate() {
    _selectedDate = widget.selectedDate.value;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      selectableDayPredicate: (DateTime date) => date.isBefore(
        DateTime.now(),
      ),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        widget.selectedDate.value = picked;
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 3,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_selectedDate.toLocal()}'.split(' ')[0],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 28,
              ),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
