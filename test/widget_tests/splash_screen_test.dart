import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movies_app/core/util/constants_routes.dart';
import 'package:movies_app/presentation/view/main_screen.dart';
import 'package:movies_app/presentation/view/splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mockito/annotations.dart';
import 'splash_screen_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<NavigatorObserver>(),
  ],
)
void main() {
  late MockNavigatorObserver mockNavObserver;

  setUp(() {
    mockNavObserver = MockNavigatorObserver();
  });

  Widget buildWidget() {
    return MaterialApp(
      home: const SplashScreen(),
      routes: {
        kSplashScreen: (context) => const SplashScreen(),
        kMainScreen: (context) => const MainScreen(),
      },
      navigatorObservers: [mockNavObserver],
    );
  }

  group('Try splash screen', () {
    testWidgets(
        'Run SplashScreen and check if the loading screen with the AnimatedSplashScreen appears',
        (tester) async {
      await tester.pumpWidget(
        buildWidget(),
      );

      expect(
        find.byType(
          AnimatedSplashScreen,
        ),
        findsOneWidget,
      );
    });
    testWidgets(
        'Check if after some seconds of running the SplashScreen the MainScreen appears',
        (tester) async {
      await tester.pumpWidget(
        buildWidget(),
      );

      expect(find.byType(MainScreen), findsNothing);
      await tester.pumpAndSettle(
        const Duration(seconds: 5),
      );
      expect(
        find.byType(MainScreen),
        findsOneWidget,
      );
    });
  });
}
