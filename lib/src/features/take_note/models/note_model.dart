import 'dart:convert';

import 'package:flutter/foundation.dart';

class NoteModel {
  final int? id;
  final String? title;
  final String note;
  final String? tags;
  final bool? isArchived;
  final bool? isLiked;
  final DateTime? edited;
  NoteModel({
    this.id,
    this.title,
    required this.note,
    this.tags,
    this.isArchived,
    this.isLiked,
    this.edited,
  });

  NoteModel copyWith({
    int? id,
    String? title,
    String? note,
    String? tags,
    bool? isArchived,
    bool? isLiked,
    DateTime? edited,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      tags: tags ?? this.tags,
      isArchived: isArchived ?? this.isArchived,
      isLiked: isLiked ?? this.isLiked,
      edited: edited ?? this.edited,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    result.addAll({'note': note});
    if (tags != null) {
      result.addAll({'tags': tags});
    }
    if (isArchived != null) {
      result.addAll({'isArchived': isArchived});
    }
    if (isLiked != null) {
      result.addAll({'isLiked': isLiked});
    }
    result.addAll({'edited': edited!.millisecondsSinceEpoch});

    return result;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id']?.toInt(),
      title: map['title'],
      note: map['note'] ?? '',
      tags: map['tags'],
      isArchived: map['isArchived'],
      isLiked: map['isLiked'],
      edited: DateTime.fromMillisecondsSinceEpoch(map['edited']),
    );
  }
}
