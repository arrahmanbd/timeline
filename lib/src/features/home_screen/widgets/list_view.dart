import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/extensions/extensions.dart';
import 'package:timeline/src/features/take_note/models/note_model.dart';

import '../../settings/controller/setting_state_controller.dart';

class ListViewWidget extends ConsumerStatefulWidget {
  final List<NoteModel> notes;
  const ListViewWidget({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GridViewWidgetState();
}

late AnimationController _animationController;

class _GridViewWidgetState extends ConsumerState<ListViewWidget>
    with TickerProviderStateMixin {
  ListTile item(int index) {
    return ListTile(
      tileColor: Colors.greenAccent.shade100.withOpacity(.25),
      title: Text(widget.notes[index].note.extractPlainText()),
      subtitle: Text(widget.notes[index].edited!.formatTimeAndDay()),
      trailing: IconButton(
        icon: const Icon(Icons.favorite_outline),
        onPressed: () {},
      ),
    );
  }

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
    return ListView.builder(
      itemCount: widget.notes.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          index: index,
          length: widget.notes.length,
          aniController: _animationController,
          animationType: settings.animation,
          child: item(index),
        );
      },
    );
  }
}
