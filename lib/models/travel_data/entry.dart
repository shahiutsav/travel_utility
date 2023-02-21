import 'dart:convert';

class Entry {
  String? uuid;
  double? distance;
  String? date;
  String? note;

  Entry({this.uuid, this.distance, this.date, this.note});

  factory Entry.fromMap(Map<String, dynamic> data) => Entry(
        uuid: data['uuid'] as String?,
        distance: (data['distance'] as num?)?.toDouble(),
        date: data['date'] as String?,
        note: data['note'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'uuid': uuid,
        'distance': distance,
        'date': date,
        'note': note,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Entry].
  factory Entry.fromJson(String data) {
    return Entry.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Entry] to a JSON string.
  String toJson() => json.encode(toMap());

  Entry copyWith({
    String? uuid,
    double? distance,
    String? date,
    String? note,
  }) {
    return Entry(
      uuid: uuid ?? this.uuid,
      distance: distance ?? this.distance,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }
}
