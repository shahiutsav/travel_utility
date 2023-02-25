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

  List<Entry> getEntriesSortedByDate() {
    List<Entry> entries = [..._entries];
    entries.sort((a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
    return entries;
  }

  void addEntry(Entry entry) async {
    await handleStorage.addEntry(entry);
    _entries.add(entry);
    notifyListeners();
  }

  Future<void> readEntries() async {
    _entries = await handleStorage.readTravelData();
    notifyListeners();
  }

  Future<void> deleteEntry(Entry entry) async {
    await handleStorage.deleteEntry(entry);
    _entries.removeWhere((entry) => entry.uuid == entry.uuid);
    notifyListeners();
  }
}
