import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/home_screen/controller/home_controller.dart';

import '../controller/home_state.dart';

class ViewChanger extends ConsumerWidget {
  const ViewChanger({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Views view = ref.watch(homeViewProvider).views;
    Widget icon() {
      switch (view) {
        case Views.gridView:
          return const Icon(Icons.list_alt_rounded);
        case Views.listView:
          return const Icon(Icons.timeline_rounded);
        case Views.timelyView:
          return const Icon(Icons.grid_view_outlined);
        default:
          return const Icon(Icons.grid_view_outlined);
      }
    }

    return icon();
  }
}
