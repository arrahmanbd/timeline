import 'dart:convert';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/utils.dart';
import '../data/rules.dart';

class EditingNotifier extends ChangeNotifier {
  String _json = '''{"insert":"12345\n"}''';
  String get string => _json;
  final heuristics = ParchmentHeuristics(
    formatRules: [],
    insertRules: [
      ForceNewlineForInsertsAroundInlineImageRule(),
    ],
    deleteRules: [],
  ).merge(ParchmentHeuristics.fallback);

  //Initial Mode
  Future<void> initController(FleatherController? _controller) async {
    try {
      final doc = ParchmentDocument.fromJson(
        jsonDecode(_json),
        heuristics: heuristics,
      );
      _controller = FleatherController(doc);
      notifyListeners();
    } catch (err, st) {
      print('Cannot read welcome.json: $err\n$st');
      _controller = FleatherController();
    }
  }

  //UNdo
  void undo(FleatherController? _controller) {
    _controller!.undo();
    notifyListeners();
  }

  //Open Note
  void openEditor(FleatherController? _controller, BuildContext context) {
    final doc = ParchmentDocument.fromJson(
      jsonDecode(_json),
      heuristics: heuristics,
    );
    Utils.showSnackBar(content: 'Note Opeing', context: context);
    _controller = FleatherController(doc);
    notifyListeners();
  }

  //Save note
  void saveNote(FleatherController? _controller, BuildContext context) {
    _json = jsonEncode(_controller!.document.toDelta().toJson());
    print(_json);
    Utils.showSnackBar(content: 'Note Picked', context: context);
    notifyListeners();
  }

  //Launcher
  void urllaunch(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    final _canLaunch = await canLaunchUrl(uri);
    if (_canLaunch) {
      await launchUrl(uri);
    }
  }
}

final editorProvider = ChangeNotifierProvider<EditingNotifier>((ref) {
  return EditingNotifier();
});
