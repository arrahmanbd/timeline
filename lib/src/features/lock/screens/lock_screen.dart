import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:timeline/src/common/values/colors.dart';
import 'package:timeline/src/features/home/screens/homepage.dart';
import 'package:timeline/src/utils/utils.dart';

import '../../../common/values/res.dart';

class LockScreen extends ConsumerWidget {
  static const String routeName = '/lockscreen';
  const LockScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Lock Timeline'),
      //   elevation: 0,
      //   backgroundColor: backgroundColor,
      // ),
      body: Center(
        child: Column(
          children: [
            LottieBuilder.asset(
              Res.lock,
              reverse: true,
              repeat: false,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Input Your PIN',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  Utils.setStatusColor(Colors.deepOrange);
                  Navigator.pushReplacementNamed(context, MyTimeLine.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
