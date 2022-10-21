import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movies_app/core/util/keys.dart';
import 'package:movies_app/core/util/service_constants.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/presentation/bloc/interfaces/i_movies_bloc.dart';
import 'package:movies_app/presentation/widget/main_screen_widget.dart';
import 'package:provider/provider.dart';

import '../mocks.dart';
import 'main_screen_test.mocks.dart';

@GenerateMocks([IMoviesBloc])
void main() {
  IMoviesBloc bloc = MockIMoviesBloc();
  StreamController<MovieEvent> streamController =
      StreamController<MovieEvent>.broadcast();
  MovieEvent movieEvent = MovieEvent(
    movies: [MovieModel.fromJson(moviesJson)],
    status: Status.success,
  );
  final String? endpointTopRated = ServiceConstants.endpoints['Top Rated'];

  tearDown(() {
    bloc.dispose();
  });

  Widget _buildWidget() {
    return Provider(
      create: (_) => bloc,
      child: const MaterialApp(
        home: MainScreenWidget(),
      ),
    );
  }

  testWidgets(
      'Main screen widget should have 3 tabs and a content container for each tab, tapping and dragging should change the current tab',
      (widgetTester) async {
    mockNetworkImages(() async {
      when(bloc.getStream()).thenAnswer((_) {
        return streamController.stream;
      });
      when(bloc.getMovies(endpointTopRated)).thenAnswer((_) async {
        streamController.sink.add(movieEvent);
      });
      await widgetTester.pumpWidget(_buildWidget());
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(Tab), findsNWidgets(3));
      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byKey(Keys.nowPlayingKey), findsOneWidget);
      expect(find.byKey(Keys.topRatedKey), findsNothing);

      await widgetTester.drag(
        find.byKey(Keys.nowPlayingKey),
        const Offset(
          -500,
          0,
        ),
      );

      await widgetTester.pump();
      streamController.sink.add(movieEvent);
      await widgetTester.pump();
      expect(
        find.byType(Image),
        findsWidgets,
      );
      expect(
        find.text('The Godfather'),
        findsOneWidget,
      );
    });
  });
}
