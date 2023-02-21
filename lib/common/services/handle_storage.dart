import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class HandleStorage {
  Future<void> createInitialData() async {
    final file = File('${(await getApplicationDocumentsDirectory()).path}/travel_data.json');

    if (!file.existsSync()) {
      final initialData = {
        "version": 1,
        "headers": "travel-data",
        "db": {"entries": []}
      };
      await file.writeAsString(json.encode(initialData));
    }
  }

  void addEntry({
    required String distance,
    required DateTime date,
    required String note,
  }) async {
    final file = File('${(await getApplicationDocumentsDirectory()).path}/travel_data.json');
    final contents = await file.readAsString();
    final data = json.decode(contents);

    final newEntry = {
      "uuid": "",
      "distance": distance,
      "date": date.toIso8601String(),
      "note": note,
    };

    data['db']['entries'].add(newEntry);
    final jsonStr = json.encode(data);
    await file.writeAsString(jsonStr);
  }
}
