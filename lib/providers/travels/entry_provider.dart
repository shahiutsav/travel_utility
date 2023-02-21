import 'package:flutter/material.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
import 'package:travel_utility/common/services/handle_storage.dart';

class EntryProvider extends ChangeNotifier {
  final HandleStorage handleStorage = HandleStorage();
  List<Entry> _entries = [];

  EntryProvider() {
    readEntries();
  }

  List<Entry> get entries {
    return [..._entries];
  }

  void addEntry(Entry entry) async {
    _entries.add(entry);
    notifyListeners();
  }

  Future<void> readEntries() async {
    _entries = await handleStorage.readTravelData();
    notifyListeners();
  }

  void removeEntry(Entry entry) {
    _entries.remove(entry);
    notifyListeners();
  }
}
