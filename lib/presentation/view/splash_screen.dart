import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/util/assets_constants.dart';
import '../../core/util/dimensions.dart';
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
      splash: Lottie.asset(AssetsConstants.kSplashScreenJson),
      duration: Dimensions.kSplashScreenDuration,
      backgroundColor: Colors.black,
      splashIconSize: Dimensions.kSplashScreenIconSize,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(
        seconds: Dimensions.kSplashScreenAnimationDuration,
      ),
    );
  }
}
