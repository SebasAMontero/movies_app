import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/core/usecases/i_usecase.dart';
import 'package:movies_app/core/util/service_constants.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/domain/repository/i_movies_repository.dart';
import 'package:movies_app/domain/usecase/get_movies_usecase.dart';

import '../../mocks.dart';
import 'get_movies_usecase_test.mocks.dart';

@GenerateMocks([IMoviesRepository])
void main() {
  late MockIMoviesRepository repository;
  late Usecase getMoviesUsecase;

  setUp(() {
    repository = MockIMoviesRepository();
    getMoviesUsecase = GetMoviesUsecase(repository);
  });

  group('Get Movies Usecase Unit Tests', () {
    test('Call method', () async {
      List<MovieModel> movieModelList = [MovieModel.fromJson(moviesJson)];
      String? endpoint = ServiceConstants.endpoints['Top Rated'];
      when(repository.fetchMovies(endpoint)).thenAnswer((_) async{
        return MovieEvent(movies: movieModelList, status: Status.success);
      });
      expectLater(await getMoviesUsecase(params: endpoint), isA<MovieEvent>());
    });
  });
}
