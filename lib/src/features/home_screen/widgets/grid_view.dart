import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:timeline/src/extensions/extensions.dart';
import 'package:timeline/src/features/settings/controller/setting_state_controller.dart';
import 'package:timeline/src/features/take_note/controller/editing_controller.dart';
import 'package:timeline/src/features/take_note/controller/editor_state.dart';

import 'package:timeline/src/features/take_note/models/note_model.dart';
import 'package:timeline/src/features/take_note/screens/editor_screen.dart';

import '../../../utils/utils.dart';

class GridViewWidget extends ConsumerStatefulWidget {
  const GridViewWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GridViewWidgetState();
}

late AnimationController _animationController;

class _GridViewWidgetState extends ConsumerState<GridViewWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingProvider);
    final List<NoteModel> notes = ref.watch(noteController).notes;

    void openNotes(int index) {
      ref.read(noteController.notifier).editMode(EditMode.update);
      Navigator.pushNamed(context, EditorScreen.routeName);
      ref.read(noteController.notifier).updateNote(notes[index]);
    }

    void deleteNote(int id) {
      ref.read(noteController.notifier).deleteNote(id);
      Utils.showSnackBar(content: 'Note Moved to Trash', context: context);
    }

    return MasonryGridView.count(
      itemCount: notes.length,
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final pick = notes[index].note.extractPlainText();
        return AnimatedListItem(
          index: index,
          length: notes.length,
          aniController: _animationController,
          animationType: settings.animation,
          child: Card(
            color: Colors.greenAccent.shade100.withOpacity(.8),
            child: MaterialButton(
              onPressed: () => openNotes(index),
              onLongPress: () => deleteNote(notes[index].id!),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notes[index].id.toString(),
                      softWrap: true,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      pick.length <= 150
                          ? pick
                          : '${pick.substring(0, 150)}...',
                      softWrap: true,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      notes[index].edited!.formatTimeAndDay(),
                      softWrap: true,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
