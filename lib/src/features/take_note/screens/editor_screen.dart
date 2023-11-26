import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/take_note/controller/editing_controller.dart';
import 'package:timeline/src/features/settings/controller/setting_state_controller.dart';

import '../../../utils/utils.dart';

class EditorScreen extends ConsumerWidget {
  static const String routeName = '/editor';
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editor = ref.watch(noteController);
    final settings = ref.watch(settingProvider);

    void saveNote() {
      ref.read(noteController.notifier).noteAction();
      Navigator.pop(context);
    }

    void openNotes() {
      //ref.read(noteController.notifier).openNote(NoteModel(note: 'note'));
      final model = ref.read(noteController).model;
      print(model.id);
      print(model.note);
      Utils.showSnackBar(content: 'Opening Documents', context: context);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => saveNote(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
            )),
        title: const Text('Write Story'),
        actions: [
          IconButton(
              onPressed: () => openNotes(), icon: const Icon(Icons.undo)),
          IconButton(
              onPressed: () => openNotes(), icon: const Icon(Icons.redo)),
          IconButton(
              onPressed: () => openNotes(),
              icon: const Icon(Icons.play_arrow_outlined))
        ],
      ),
      body: QuillProvider(
        configurations: QuillConfigurations(
          controller: editor.controller,
          sharedConfigurations: QuillSharedConfigurations(
            locale: Locale(settings.editorlang.toString()),
          ),
        ),
        child: Column(
          verticalDirection:
              settings.isBottom ? VerticalDirection.up : VerticalDirection.down,
          children: [
            QuillToolbar(
              configurations: QuillToolbarConfigurations(
                  multiRowsDisplay: settings.isExpand,
                  showAlignmentButtons: settings.isBottom,
                  showFontSize: false,
                  //color: Colors.white,

                  showBackgroundColorButton: false,
                  showFontFamily: false),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: const Color.fromARGB(76, 255, 193, 7)),
                ),
                child: QuillEditor.basic(
                  configurations: const QuillEditorConfigurations(
                    readOnly: false,
                    scrollable: true,
                    padding: EdgeInsets.all(8),
                    autoFocus: true,
                    expands: false,
                    placeholder: 'Add your story here...',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
