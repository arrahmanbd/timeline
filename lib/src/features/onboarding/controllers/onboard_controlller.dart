import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/common/values/strings.dart';

import '../../../common/values/res.dart';
import '../model/page_model.dart';

class OnBoardNotifier extends ChangeNotifier {
  List<PageModel> _mySlides = [];
  int _slideIndex = 0;
  OnBoardNotifier() {
    getSlides();
  }

  int get slideIndex => _slideIndex;
  List<PageModel> get mySlides => _mySlides;

  getSlides() {
    List<PageModel> slides = [];
    slides.add(PageModel(
        title: AppString.slider1,
        message: AppString.message1,
        asset: Res.home));
    slides.add(PageModel(
        title: AppString.slider2,
        message: AppString.message2,
        asset: Res.onboarding_animation));
    slides.add(PageModel(
        title: AppString.slider3,
        message: AppString.message3,
        asset: Res.travel_tickets));
    _mySlides = slides;

    notifyListeners();
  }

  onChange(int index) {
    print(index);
    if (index < _mySlides.length) {
      _slideIndex = index;
    }
    notifyListeners();
  }
}

final onBoardProvider = ChangeNotifierProvider<OnBoardNotifier>((ref) {
  return OnBoardNotifier();
});
