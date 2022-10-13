import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/core/util/service_constants.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/domain/usecase/get_movies_usecase.dart';
import 'package:movies_app/presentation/bloc/interfaces/i_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies_bloc_impl.dart';

import '../../mocks.dart';
import 'movies_bloc_test.mocks.dart';

@GenerateMocks([GetMoviesUsecase])
void main() {
  late MockGetMoviesUsecase usecase;
  late IMoviesBloc bloc;

  setUp(() {
    usecase = MockGetMoviesUsecase();
    bloc = MoviesBloc(usecase);
  });

  tearDown(() {
    bloc.dispose();
  });

  group('Movies Bloc Unit Testing', () {
    test('Get Stream Unit Test', () async {
      Stream stream = bloc.getStream();
      expect(
        stream,
        isA<Stream>(),
      );
    });

    test('Movies Bloc getMovies method', () async {
      List<MovieModel> listOfMovies = [MovieModel.fromJson(moviesJson)];
      when(
        usecase(
          params: ServiceConstants.endpoints['Top Rated'],
        ),
      ).thenAnswer((_) async {
        return MovieEvent(
          movies: listOfMovies,
          status: Status.success,
        );
      });
      Stream streamBloc = bloc.getStream();
      expect(
        streamBloc,
        emits(isA<MovieEvent>()),
      );
      await bloc.getMovies(ServiceConstants.endpoints['Top Rated']);
    });

    test('Movies Bloc getMovies method when error occurs', () async {
      when(
        usecase(
          params: ServiceConstants.endpoints['Top Rated'],
        ),
      ).thenAnswer((_) async {
        return MovieEvent(
          status: Status.error,
        );
      });
      Stream streamBloc = bloc.getStream();
      expect(
        streamBloc,
        emits(isA<MovieEvent>()),
      );
      await bloc.getMovies(ServiceConstants.endpoints['Top Rated']);
    });

    test('Movies Bloc getMovies method with empty list of movies', () async {
      when(
        usecase(
          params: ServiceConstants.endpoints['Top Rated'],
        ),
      ).thenAnswer((_) async {
        return MovieEvent(
          status: Status.empty,
        );
      });
      Stream streamBloc = bloc.getStream();
      expect(
        streamBloc,
        emits(isA<MovieEvent>()),
      );
      await bloc.getMovies(ServiceConstants.endpoints['Top Rated']);
    });
  });
}
