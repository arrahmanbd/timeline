import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_state.dart';

class HomeViewNotifier extends StateNotifier<HomeViewState> {
  final HomeViewState viewState;
  HomeViewNotifier(
    this.viewState,
  ) : super(viewState);

  void changeView(Views views) {
    switch (views) {
      case Views.gridView:
        state = state.copyWith(views: Views.gridView);
      case Views.listView:
        state = state.copyWith(views: Views.listView);
      case Views.timelyView:
        state = state.copyWith(views: Views.timelyView);
      default:
        state = state.copyWith(views: Views.gridView);
    }
  }

  void toggle() {
    print(state.views.index);
    switch (state.views) {
      case Views.gridView:
        changeView(Views.listView);
        break;
      case Views.listView:
        changeView(Views.timelyView);
        break;
      case Views.timelyView:
        changeView(Views.gridView);
        break;
    }
  }
}

final homeViewProvider =
    StateNotifierProvider<HomeViewNotifier, HomeViewState>((ref) {
  return HomeViewNotifier(HomeViewState(views: Views.gridView));
});
