import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/home_screen/controller/home_controller.dart';
import 'package:timeline/src/features/home_screen/widgets/timeline_view.dart';
import 'package:timeline/src/features/home_screen/widgets/view_changer.dart';
import 'package:timeline/src/features/searching/screens/search_view.dart';
import 'package:timeline/src/features/take_note/controller/editing_controller.dart';

import '../../../common/animation/animated_button.dart';
import '../../settings/screen/setting_screen.dart';
import '../../take_note/controller/editor_state.dart';
import '../../take_note/models/note_model.dart';
import '../../take_note/screens/editor_screen.dart';
import '../controller/home_state.dart';
import '../widgets/grid_view.dart';
import '../widgets/list_view.dart';

class MyTimeLine extends ConsumerWidget {
  static const String routeName = '/home';
  const MyTimeLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<NoteModel> notes = ref.watch(noteController).notes;
    final views = ref.watch(homeViewProvider).views;
    void changeMode() {
      ref.read(homeViewProvider.notifier).toggle();
    }

    Widget bodyWidget() {
      switch (views) {
        case Views.gridView:
          return const GridViewWidget();

        case Views.listView:
          return ListViewWidget(
            notes: notes,
          );

        case Views.timelyView:
          return TimeViewWidget(
            notes: notes,
          );
        default:
          return const GridViewWidget();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        title: const Text(
          'TimeLine',
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(homeViewProvider.notifier).toggle();
              },
              icon: const ViewChanger()),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingScreen.routeName);
              },
              icon: const Icon(Icons.more_vert_outlined)),
        ],
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SearchScreen(
                  noteSearch: notes,
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(child: bodyWidget()),
            ],
          )),
      //TimeLineView(notes: notes),
      floatingActionButton: InkWell(
        onLongPress: () {
          //ref.read(noteProvider).clear();
        },
        child: FloatingActionButton(
          onPressed: () {
            ref.read(noteController.notifier).editMode(EditMode.newNote);
            Navigator.pushNamed(context, EditorScreen.routeName);
            // ref.read(noteProvider).add();
          },
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
