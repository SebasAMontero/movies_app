import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movies_app/core/util/service_constants.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/presentation/bloc/interfaces/i_movies_bloc.dart';
import 'package:movies_app/presentation/view/upcoming.dart';
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
  final String? endpointUpcoming = ServiceConstants.endpoints['Upcoming'];

  tearDown(() {
    bloc.dispose();
  });

  Widget _buildWidget() {
    return Provider(
      create: (_) => bloc,
      child: const MaterialApp(
        home: Upcoming(),
      ),
    );
  }

  testWidgets(
      'Upcoming View Widget Test, should have Carousel Slider with Image and Text',
          (widgetTester) async {
        mockNetworkImages(() async {
          when(bloc.getStream()).thenAnswer((_) {
            return streamController.stream;
          });
          when(bloc.getMovies(endpointUpcoming)).thenAnswer((_) async {
            streamController.sink.add(movieEvent);
          });
          await widgetTester.pumpWidget(_buildWidget());
          streamController.sink.add(movieEvent);
          await widgetTester.pump();
          expect(
            find.byType(
              CarouselSlider,
            ),
            findsOneWidget,
          );
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
