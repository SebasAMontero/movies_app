import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/util/constants_assets.dart';
import '../../core/util/constants_dimensions.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const MainScreen(),
      splash: Lottie.asset(kSplashScreenJson),
      duration: kSplashScreenDuration,
      backgroundColor: Colors.black,
      splashIconSize: kSplashScreenIconSize,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(
        seconds: kSplashScreenAnimationDuration,
      ),
    );
  }
}
