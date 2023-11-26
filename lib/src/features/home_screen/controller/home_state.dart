class HomeViewState {
  final Views views;
  HomeViewState({
    required this.views,
  });

  HomeViewState copyWith({
    Views? views,
  }) {
    return HomeViewState(
      views: views ?? this.views,
    );
  }
}

enum Views { gridView, listView, timelyView }
