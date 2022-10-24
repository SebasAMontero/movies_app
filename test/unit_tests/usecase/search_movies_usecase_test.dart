import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/core/usecases/i_usecase.dart';
import 'package:movies_app/core/util/status_enum.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/domain/repository/i_movies_repository.dart';
import 'package:movies_app/domain/usecase/search_movies_usecase.dart';

import '../../mocks.dart';
import 'get_movies_usecase_test.mocks.dart';

@GenerateMocks([IMoviesRepository])
void main() {
  late MockIMoviesRepository repository;
  late UseCase getMoviesUsecase;

  setUp(() {
    repository = MockIMoviesRepository();
    getMoviesUsecase = SearchMoviesUseCase(repository);
  });

  group('Search Movies Usecase Unit Tests', () {
    test('Call method', () async {
      List<MovieModel> movieModelList = [MovieModel.fromJson(moviesJson)];
      String keyword = 'keyword';
      when(repository.searchMovies(keyword)).thenAnswer((_) async {
        return MovieEvent(movies: movieModelList, status: Status.success);
      });
      expectLater(await getMoviesUsecase(params: keyword), isA<MovieEvent>());
    });
  });
}
