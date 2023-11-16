// note_model.dart
import 'package:flutter/foundation.dart';

class Note {
  final int id;
  final String title;
  final String note;
  final DateTime time;
  final List<String> labels;

  Note({
    required this.id,
    required this.title,
    required this.note,
    required this.time,
    required this.labels,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'time': time.toIso8601String(),
      'labels': labels
          .join(','), // Serialize list of labels to a comma-separated string
    };
  }

  // Deserialize list of labels from string
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      note: map['note'],
      time: DateTime.parse(map['time']),
      labels: map['labels']
          .split(','), // Split the string to recreate the list of labels
    );
  }
}
