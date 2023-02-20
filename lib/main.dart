import 'package:flutter/material.dart';
import 'package:travel_utility/common/widgets/date_picker_form_field.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final TextEditingController _distanceTraveledController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final distanceTraveledFocusNode = FocusNode();
  final noteFocusNode = FocusNode();

  void _unFocus() {
    distanceTraveledFocusNode.unfocus();
    noteFocusNode.unfocus();
  }

  void _saveTravel({
    required String distanceTraveled,
    required DateTime date,
    required String note,
  }) {
    final data = [
      {
        'distanceTraveled': distanceTraveled,
        'date': date,
        'note': note,
      },
    ];
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateToSave = DateTime.now();
    return MaterialApp(
      home: GestureDetector(
        onTap: _unFocus,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatePickerFormField(
                    labelText: 'Select a date',
                    onDateSelected: (selectedDate) {
                      dateToSave = selectedDate;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _distanceTraveledController,
                    focusNode: distanceTraveledFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Distance Traveled',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _noteController,
                    focusNode: noteFocusNode,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Note',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _unFocus();
                      _saveTravel(
                        distanceTraveled: _distanceTraveledController.text,
                        date: dateToSave,
                        note: _noteController.text,
                      );
                    },
                    child: const Text('Save Travel'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
