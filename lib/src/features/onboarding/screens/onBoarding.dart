import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeline/src/features/lock_screen/screens/lock_screen.dart';
import 'package:timeline/src/features/onboarding/controllers/onboard_controlller.dart';
import 'package:timeline/src/features/settings/controller/setting_state_controller.dart';

import '../../../common/widgets/button.dart';

class OnBoarding extends ConsumerWidget {
  static const String routeName = '/onboard';
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final media = MediaQuery.of(context).size;
    final mySlides = ref.watch(onBoardProvider).mySlides;
    final slideIndex = ref.watch(onBoardProvider).slideIndex;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          SizedBox(
              //width: media.width * 0.9,
              height: media.height * 0.6,
              child: Center(
                child: CarouselSlider(
                    items: List.generate(
                      mySlides.length,
                      (index) => LottieBuilder.asset(
                        mySlides[index].asset,
                        fit: BoxFit.contain,
                      ),
                    ),
                    options: CarouselOptions(
                      height: media.height,
                      viewportFraction: 1,
                      disableCenter: true,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, _) {
                        ref.read(onBoardProvider).onChange(index);
                      },
                      scrollDirection: Axis.horizontal,
                    )),
              )),
          SizedBox(
            height: media.height * 0.01,
          ),
          AnimatedSmoothIndicator(
            count: mySlides.length,
            activeIndex: slideIndex,
            effect: ScrollingDotsEffect(
              activeDotColor: Colors.orange,
              dotHeight: 8,
              strokeWidth: 1,
              dotWidth: 8,
              dotColor: Colors.orange.withOpacity(0.5),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              mySlides[slideIndex].title,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              mySlides[slideIndex].message,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: media.height * 0.03,
          ),
          SizedBox(
            width: media.width * 0.75,
            child: CustomButton(
                text: slideIndex == 2 ? 'Continue' : 'Skip',
                onPressed: () {
                  ref.read(onBoardProvider).onChange(slideIndex + 1);
                  ref.read(settingProvider.notifier).onBoarding(false);
                  if (slideIndex == 2)
                    Navigator.pushNamed(context, LockScreen.routeName);
                }),
          )
        ],
      ),
    );
  }
}
