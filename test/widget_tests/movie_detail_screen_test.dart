import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'package:movies_app/core/util/status_enum.dart';
import 'package:movies_app/data/model/movie_detail_model.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_detail_event.dart';
import 'package:movies_app/presentation/bloc/interfaces/i_movies_bloc.dart';
import 'package:movies_app/presentation/view/main_screen.dart';
import 'package:movies_app/presentation/view/movie_detail_screen.dart';
import 'package:provider/provider.dart';
import '../mocks.dart';
import 'movie_detail_screen_test.mocks.dart';

@GenerateMocks(
  [IMoviesBloc],
)
void main() {
  late MockIMoviesBloc moviesBloc;
  MovieModel movieModel = MovieModel.fromJson(moviesJson);

  setUp(() {
    moviesBloc = MockIMoviesBloc();
  });

  Widget buildWidget() {
    return Provider<IMoviesBloc>(
      create: (_) => moviesBloc,
      child: MaterialApp(
        home: MovieDetailScreen(
          movie: movieModel,
        ),
      ),
    );
  }

  group('Try movie detail screen', () {
    testWidgets('Run  movie detail screen and check if a SliverAppBar appears',
            (widgetTester) async {
          when(moviesBloc.getSpecificMovie(movieModel)).thenAnswer(
                (_) async =>
                MovieDetailEvent(
                  status: Status.success,
                  movie: MovieDetailModel.fromJson(detailedMovieJson),
                ),
          );
          await widgetTester.pumpWidget(
            buildWidget(),
          );

          expect(
            find.byType(
              SliverAppBar,
            ),
            findsOneWidget,
          );
        });
    testWidgets('Run movie detail screen and check if a SliverList appears',
            (widgetTester) async {
          when(moviesBloc.getSpecificMovie(movieModel)).thenAnswer((_) async {
            return MovieDetailEvent(
              status: Status.success,
              movie: MovieDetailModel.fromJson(detailedMovieJson),
            );
          });
          await widgetTester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(MainScreen), findsNothing);

          expect(
            find.byType(SliverList),
            findsOneWidget,
          );
        });
    testWidgets(
        'Run movie detail screen and check if the FutureBuilder appears',
            (widgetTester) async {
          when(moviesBloc.getSpecificMovie(movieModel)).thenAnswer((_) async {
            return MovieDetailEvent(
              status: Status.success,
              movie: MovieDetailModel.fromJson(detailedMovieJson),
            );
          });
          await widgetTester.pumpWidget(
            buildWidget(),
          );

          expect(
            find.byType(FutureBuilder<MovieDetailEvent>),
            findsOneWidget,
          );
        });

    testWidgets(
        'The screen should have VisibilityText widget for the simple attributes',
            (widgetTester) async {
          mockNetworkImages(() async {
            when(moviesBloc.getSpecificMovie(movieModel)).thenAnswer((_) async {
              return MovieDetailEvent(
                status: Status.success,
                movie: MovieDetailModel.fromJson(detailedMovieJson),
              );
            });

            await widgetTester.pumpWidget(
              buildWidget(),
            );

            await widgetTester.pump();

            expect(
              find.text(
                'The Godfather',
              ),
              findsOneWidget,
            );
            expect(
              find.byType(
                Image,
              ),
              findsWidgets,
            );
          });
        });
  });
}
