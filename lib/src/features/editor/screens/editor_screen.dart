import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/editor/controller/editing_controller.dart';
import 'package:timeline/src/features/settings/controller/setting_state_controller.dart';

import '../../../utils/utils.dart';

class EditorScreen extends ConsumerStatefulWidget {
  static const String routeName = '/editor';
  const EditorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  final QuillController _controller = QuillController.basic();

  void saveNote(BuildContext context) {
    String data = jsonEncode(_controller.document.toDelta().toJson());
    ref.read(editorProvider.notifier).pickNote(data);
    Utils.showSnackBar(content: 'Note Saved', context: context);
  }

  void openNotes(BuildContext context) {
    ref.read(editorProvider.notifier).openNote(_controller);
    Utils.showSnackBar(content: 'Opening Documents', context: context);
  }

  @override
  Widget build(BuildContext context) {
    final editor = ref.watch(editorProvider);
    final settings = ref.watch(settingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Story'),
        actions: [
          IconButton(
              onPressed: () => saveNote(context), icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () => openNotes(context),
              icon: const Icon(Icons.play_arrow_outlined))
        ],
      ),
      body: QuillProvider(
        configurations: QuillConfigurations(
          controller: _controller,
          sharedConfigurations: QuillSharedConfigurations(
            locale: Locale(editor.locale),
          ),
        ),
        child: Column(
          children: [
            QuillToolbar(
              configurations: QuillToolbarConfigurations(
                multiRowsDisplay: settings.isExpand,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.amber),
              ),
              child: QuillEditor.basic(
                configurations: const QuillEditorConfigurations(
                  readOnly: false,
                  padding: EdgeInsets.all(8),
                  autoFocus: true,
                  expands: false,
                  placeholder: 'Add your story here...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
