import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';

class HandleStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/travel_data.json');
  }

  Future<void> createInitialData() async {
    final file = await _localFile;

    if (!file.existsSync()) {
      final initialData = {
        "version": 1,
        "headers": "travel-data",
        "db": {"entries": []}
      };
      await file.writeAsString(json.encode(initialData));
    }
  }

  Future<void> addEntry(
    Entry entry,
  ) async {
    final file = await _localFile;
    final contents = await file.readAsString();
    final data = json.decode(contents);

    data['db']['entries'].add(entry);
    final jsonStr = json.encode(data);
    await file.writeAsString(jsonStr);
  }

  Future<List<Entry>> readTravelData() async {
    List<Entry> travelData = [];
    final file = await _localFile;
    final contents = await file.readAsString();
    final data = json.decode(contents);
    final entriesData = data['db']['entries'];

    for (var entryData in entriesData) {
      final entry = Entry.fromJson(entryData);
      travelData.add(entry);
    }
    return travelData;
  }

  Future<void> deleteEntry(
    Entry entry,
  ) async {
    final file = await _localFile;
    final contents = await file.readAsString();
    final data = json.decode(contents);

    final entriesData = data['db']['entries'];
    final entries = [];

    for (var entryData in entriesData) {
      final entry = Entry.fromJson(entryData);
      entries.add(entry);
    }
    entries.removeWhere(
      (element) => element.uuid == entry.uuid,
    );
    data['db']['entries'] = entries;

    final jsonStr = json.encode(data);
    await file.writeAsString(jsonStr);
  }
}
