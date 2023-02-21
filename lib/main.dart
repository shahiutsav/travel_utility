import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:travel_utility/common/services/handle_storage.dart';
import 'package:travel_utility/common/widgets/date_picker_form_field.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HandleStorage().createInitialData().then((_) {
    runApp(MainApp());
  });
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final HandleStorage saveData = HandleStorage();

  final TextEditingController _distanceTraveledController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final distanceTraveledFocusNode = FocusNode();
  final noteFocusNode = FocusNode();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void _unFocus() {
    distanceTraveledFocusNode.unfocus();
    noteFocusNode.unfocus();
  }

  void _clearController() {
    _distanceTraveledController.clear();
    _noteController.clear();
  }

  void _saveTravel({
    required String distanceTraveled,
    required DateTime date,
    required String note,
  }) {
    saveData.addEntry(
      distance: distanceTraveled,
      date: date,
      note: note,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateToSave = DateTime.now();
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: GestureDetector(
          onTap: _unFocus,
          child: Padding(
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
                      _saveTravel(
                        distanceTraveled: _distanceTraveledController.text,
                        date: dateToSave,
                        note: _noteController.text,
                      );
                      showFlushbar(navigatorKey.currentContext!);
                      _unFocus();
                      _clearController();
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

void showFlushbar(BuildContext context) {
  Flushbar(
    message: 'The data has been saved',
    icon: Icon(
      Icons.check,
      size: 28.0,
      color: Colors.green.shade300,
    ),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    leftBarIndicatorColor: Colors.green.shade300,
    duration: const Duration(seconds: 3),
  ).show(context);
}
