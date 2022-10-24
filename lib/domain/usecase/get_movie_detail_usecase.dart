import '../../core/usecases/i_usecase.dart';
import '../../data/model/movie_model.dart';
import '../entity/movie_detail_event.dart';
import '../repository/i_movies_repository.dart';

class GetMovieDetailUseCase implements UseCase<MovieDetailEvent, MovieModel> {
  final IMoviesRepository _moviesRepository;

  GetMovieDetailUseCase(this._moviesRepository);

  @override
  Future<MovieDetailEvent> call({MovieModel? params}) async {
    return await _moviesRepository.fetchMovieDetail(params);
  }
}
