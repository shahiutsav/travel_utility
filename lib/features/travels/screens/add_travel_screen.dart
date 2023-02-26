import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
import 'package:travel_utility/common/services/handle_storage.dart';
import 'package:travel_utility/common/widgets/custom_input_field.dart';
import 'package:travel_utility/common/widgets/date_picker_form_field.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:travel_utility/common/widgets/stacked_card.dart';
import 'package:travel_utility/providers/travels/entry_provider.dart';
import 'package:uuid/uuid.dart';

class AddTravelScreen extends StatelessWidget {
  static const String routeName = '/add_travel';
  AddTravelScreen({super.key});

  final HandleStorage saveData = HandleStorage();

  final TextEditingController _distanceTraveledController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final distanceTraveledFocusNode = FocusNode();
  final noteFocusNode = FocusNode();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final _formKey = GlobalKey<FormState>();

  void _unFocus() {
    distanceTraveledFocusNode.unfocus();
    noteFocusNode.unfocus();
  }

  void _clearController() {
    _distanceTraveledController.clear();
    _noteController.clear();
  }

  Future<void> saveTravel({
    required String distanceTraveled,
    required DateTime date,
    required String note,
    required BuildContext context,
  }) async {
    const uuid = Uuid();
    var newUuid = uuid.v1();
    final newEntry = Entry(
      distance: double.parse(distanceTraveled),
      date: date.toIso8601String(),
      note: note,
      uuid: newUuid,
    );
    final entryProvider = Provider.of<EntryProvider>(context, listen: false);
    entryProvider.addEntry(newEntry);
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateToSave = DateTime.now();
    return GestureDetector(
      onTap: _unFocus,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DatePickerFormField(
                  labelText: 'Select a date',
                  onDateSelected: (selectedDate) {
                    saveData.readTravelData();
                    dateToSave = selectedDate;
                  },
                ),
                const SizedBox(height: 18),
                CustomInputField(
                  labelText: 'Distance Traveled',
                  controller: _distanceTraveledController,
                  focusNode: distanceTraveledFocusNode,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a distance';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                CustomInputField(
                  labelText: 'Note',
                  controller: _noteController,
                  focusNode: noteFocusNode,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 3,
                ),
                StackedCard(
                  color: Colors.blue.shade300,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 8,
                  enableTap: true,
                  onTap: () {
                    if (validateAndSave()) {
                      saveTravel(
                        context: context,
                        distanceTraveled: _distanceTraveledController.text,
                        date: dateToSave,
                        note: _noteController.text,
                      ).then(
                        (_) {
                          _clearController();
                          _unFocus();
                          Navigator.pop(context);
                          showFlushbar(context);
                        },
                      );
                    }
                  },
                  child: const Center(
                    child: Text(
                      'Save Travel',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

void showFlushbar(BuildContext context) {
  Flushbar(
    message: 'The data has been saved',
    icon: const Icon(
      Icons.check,
      size: 28.0,
      color: Colors.green,
    ),
    messageColor: Colors.black,
    borderColor: Colors.black,
    borderWidth: 3,
    backgroundColor: Colors.white,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    leftBarIndicatorColor: Colors.green,
    duration: const Duration(seconds: 3),
  ).show(context);
}
