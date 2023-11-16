import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:timeline/src/features/editor/providers/state.dart';

import '../../../utils/utils.dart';
import '../data/rules.dart';

class EditingNotifier extends StateNotifier<EditingState> {
  EditingNotifier() : super(EditingState('{"insert":"12345\n"}'));
  final heuristics = ParchmentHeuristics(
    formatRules: [],
    insertRules: [
      ForceNewlineForInsertsAroundInlineImageRule(),
    ],
    deleteRules: [],
  ).merge(ParchmentHeuristics.fallback);

  // Initial Mode
  Future<void> initController(FleatherController? _controller) async {
    try {
      final doc = ParchmentDocument.fromJson(
        jsonDecode(state.jsonString),
        heuristics: heuristics,
      );
      _controller = FleatherController(doc);
    } catch (err, st) {
      print('Cannot read welcome.json: $err\n$st');
      _controller = FleatherController();
    }
  }

  // UNdo
  void undo(FleatherController? _controller) {
    _controller!.undo();
  }

  // Open Note
  ParchmentDocument openEditor(BuildContext context) {
    final doc = ParchmentDocument.fromJson(
      jsonDecode(state.jsonString),
      heuristics: heuristics,
    );
    Utils.showSnackBar(content: 'Note Opening', context: context);
    return doc;
  }

  // Save note
  void saveNote(FleatherController? _controller, BuildContext context) {
    state = EditingState(jsonEncode(_controller!.document.toDelta().toJson()));
    print(state.jsonString);
    Utils.showSnackBar(content: 'Note Picked', context: context);
  }

  // Launcher
  void urllaunch(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    final _canLaunch = await canLaunchUrl(uri);
    if (_canLaunch) {
      await launchUrl(uri);
    }
  }
}

final editorProvider =
    StateNotifierProvider<EditingNotifier, EditingState>((ref) {
  return EditingNotifier();
});
