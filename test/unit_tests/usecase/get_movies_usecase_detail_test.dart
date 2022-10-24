import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/core/usecases/i_usecase.dart';

import 'package:movies_app/core/util/status_enum.dart';
import 'package:movies_app/data/model/movie_detail_model.dart';

import 'package:movies_app/domain/entity/movie_detail_event.dart';

import 'package:movies_app/domain/repository/i_movies_repository.dart';
import 'package:movies_app/domain/usecase/get_movie_detail_usecase.dart';

import '../../mocks.dart';
import 'get_movies_usecase_test.mocks.dart';

@GenerateMocks([IMoviesRepository])
void main() {
  late MockIMoviesRepository repository;
  late UseCase getMovieDetailUseCase;

  setUp(() {
    repository = MockIMoviesRepository();
    getMovieDetailUseCase = GetMovieDetailUseCase(repository);
  });

  group('Get Movie Detail UseCase Unit Tests', () {
    test('Call method', () async {
      MovieDetailModel movieDetailModel =
          MovieDetailModel.fromJson(movieDetailJson);

      when(repository.fetchMovieDetail(movieModelMock)).thenAnswer((_) async {
        return MovieDetailEvent(
          movie: movieDetailModel,
          status: Status.success,
        );
      });
      expectLater(
        await getMovieDetailUseCase(params: movieModelMock),
        isA<MovieDetailEvent>(),
      );
    });
  });
}
