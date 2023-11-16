import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/values/res.dart';
import '../model/page_model.dart';

class OnBoardController extends StateNotifier<OnBoardState> {
  OnBoardController() : super(OnBoardState());

  List<PageModel> getSlides() {
    List<PageModel> slides = [];
    slides = [
      PageModel(title: 'hello1', message: 'New', asset: Res.home),
      PageModel(
          title: 'hello2', message: 'New', asset: Res.onboarding_animation),
      PageModel(title: 'hello3', message: 'New', asset: Res.travel_tickets),
    ];
    return slides;
  }

  void onChange(int index) {
    state = state.copyWith(slideIndex: index);
  }
}

class OnBoardState {
  final int slideIndex;
  final List<PageModel> mySlides;

  OnBoardState({this.mySlides = const [], this.slideIndex = 0});

  OnBoardState copyWith({int? slideIndex, List<PageModel>? mySlides}) {
    return OnBoardState(
      slideIndex: slideIndex ?? this.slideIndex,
      mySlides: mySlides ?? this.mySlides,
    );
  }
}

final onBoardProvider =
    StateNotifierProvider<OnBoardController, OnBoardState>((ref) {
  return OnBoardController();
});
