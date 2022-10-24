import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:movies_app/core/util/constants_routes.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/presentation/bloc/interfaces/i_movies_bloc.dart';
import 'package:movies_app/presentation/view/main_screen.dart';
import 'package:movies_app/presentation/view/splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import '../mocks.dart';
import 'splash_screen_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<NavigatorObserver>(),
  ],
)
@GenerateMocks([IMoviesBloc])
void main() {
  late MockNavigatorObserver mockNavObserver;
  IMoviesBloc bloc = MockIMoviesBloc();
  StreamController<MovieEvent> streamController =
      StreamController<MovieEvent>.broadcast();

  setUp(() {
    mockNavObserver = MockNavigatorObserver();
  });

  tearDown(() => bloc.dispose());

  Widget buildWidget() {
    return Provider(
      create: (_) => bloc,
      child: MaterialApp(
        home: const SplashScreen(),
        routes: {
          kSplashScreen: (context) => const SplashScreen(),
          kMainScreen: (context) => const MainScreen(),
        },
        navigatorObservers: [mockNavObserver],
      ),
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
  });
}
