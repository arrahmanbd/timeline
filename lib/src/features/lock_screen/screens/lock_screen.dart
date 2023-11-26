import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:timeline/src/features/lock_screen/controllers/lock_screen_controller.dart';

import '../../../common/values/res.dart';
import '../../../utils/utils.dart';
import '../../home_screen/screens/homepage.dart';

class LockScreen extends ConsumerWidget {
  static const String routeName = '/lockscreen';
  const LockScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final locker = ref.watch(lockProvider);
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
            Text(
              locker.isNewUser ? 'Create Your PIN' : 'Input Your Pin',
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
                  ref.read(lockProvider.notifier).checkLock(val);
                  if (val.length == 4) {
                    print('Encrypting');
                    if (locker.isNewUser && locker.isSuccess) {
                      print('New user detected');
                      Navigator.pushNamed(context, MyTimeLine.routeName);
                      Utils.showSnackBar(
                          context: context, content: 'Welcome New User');
                    } else if (locker.isSuccess) {
                      print('PassCode matched');
                      Navigator.pushNamed(context, MyTimeLine.routeName);
                      Utils.showSnackBar(
                          context: context, content: 'Login Success');
                    } else {
                      print('Decryption failed');
                      Utils.showSnackBar(
                          context: context, content: 'Wrong Password');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
