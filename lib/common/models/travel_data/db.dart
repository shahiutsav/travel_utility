import 'dart:convert';

import 'entry.dart';

class Db {
  List<Entry>? entries;

  Db({this.entries});

  factory Db.fromMap(Map<String, dynamic> data) => Db(
        entries: (data['entries'] as List<dynamic>?)
            ?.map((e) => Entry.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'entries': entries?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Db].
  factory Db.fromJson(String data) {
    return Db.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Db] to a JSON string.
  String toJson() => json.encode(toMap());

  Db copyWith({
    List<Entry>? entries,
  }) {
    return Db(
      entries: entries ?? this.entries,
    );
  }
}
