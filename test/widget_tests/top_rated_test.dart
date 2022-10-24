import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/presentation/bloc/interfaces/i_movies_bloc.dart';
import 'package:movies_app/presentation/view/top_rated.dart';
import 'package:provider/provider.dart';

import '../mocks.dart';
import 'top_rated_test.mocks.dart';

@GenerateMocks([IMoviesBloc])
void main() {
  IMoviesBloc bloc = MockIMoviesBloc();
  StreamController<MovieEvent> streamController =
  StreamController();
  MovieEvent movieEvent = MovieEvent(
    movies: [MovieModel.fromJson(moviesJson)],
    status: Status.success,
  );

  tearDown(() {
    bloc.dispose();
  });

  Widget _buildWidget() {
    return Provider(
      create: (_) => bloc,
      child: const MaterialApp(
        home: TopRated(),
      ),
    );
  }

  testWidgets(
      'Top Rated should have an Image (poster image) and a Text (movie title)',
          (widgetTester) async {
        mockNetworkImages(() async {
          when(bloc.getStream()).thenAnswer((_) {
            return streamController.stream;
          });
          await widgetTester.pumpWidget(_buildWidget());

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
