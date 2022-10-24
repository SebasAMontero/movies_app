import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/core/util/constants.dart';
import 'package:movies_app/core/util/keys.dart';
import 'package:movies_app/core/util/status_enum.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/presentation/bloc/interfaces/i_movies_bloc.dart';
import 'package:movies_app/presentation/view/search_view.dart';
import 'package:provider/provider.dart';

import '../mocks.dart';
import 'main_screen_test.mocks.dart';

@GenerateMocks([IMoviesBloc])
void main() {
  IMoviesBloc bloc = MockIMoviesBloc();
  StreamController<MovieEvent> streamController = StreamController();
  MovieEvent movieEvent = MovieEvent(
    movies: [MovieModel.fromJson(moviesJson)],
    status: Status.success,
  );
  MovieEvent loadingMovieEvent = MovieEvent(
    movies: [MovieModel.fromJson(moviesJson)],
    status: Status.loading,
  );
  const String keyword = 'keyword';

  tearDown(() {
    bloc.dispose();
  });

  Widget _buildWidget() {
    return Provider(
      create: (_) => bloc,
      child: MaterialApp(
        home: SearchView(
          tabActual: Constants.tabEndpoints[0]!,
        ),
      ),
    );
  }

  testWidgets(
      'Search widget should display the movies given by the bloc\'s stream',
      (widgetTester) async {
    when(bloc.getStream()).thenAnswer((_) {
      return streamController.stream;
    });
    when(bloc.searchMovies(keyword)).thenAnswer((_) async {
      streamController.sink.add(movieEvent);
    });
    await widgetTester.pumpWidget(_buildWidget());

    streamController.sink.add(loadingMovieEvent);
    await widgetTester.pump();

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );

    streamController.sink.add(movieEvent);

    await widgetTester.pump(const Duration(seconds: 1));
    expect(
      find.byKey(Keys.movieListItemKey),
      findsOneWidget,
    );
  });
}
