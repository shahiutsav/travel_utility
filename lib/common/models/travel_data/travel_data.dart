import 'dart:convert';

import 'db.dart';

class TravelData {
  int? version;
  String? headers;
  Db? db;

  TravelData({this.version, this.headers, this.db});

  factory TravelData.fromMap(Map<String, dynamic> data) => TravelData(
        version: data['version'] as int?,
        headers: data['headers'] as String?,
        db: data['db'] == null
            ? null
            : Db.fromMap(data['db'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'version': version,
        'headers': headers,
        'db': db?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TravelData].
  factory TravelData.fromJson(String data) {
    return TravelData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TravelData] to a JSON string.
  String toJson() => json.encode(toMap());

  TravelData copyWith({
    int? version,
    String? headers,
    Db? db,
  }) {
    return TravelData(
      version: version ?? this.version,
      headers: headers ?? this.headers,
      db: db ?? this.db,
    );
  }
}
