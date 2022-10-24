import '../../data/model/movie_model.dart';
import '../entity/movie_detail_event.dart';
import '../entity/movie_event.dart';

abstract class IMoviesRepository {
  Future<MovieEvent> fetchMovies(endpoint);

  Future<MovieDetailEvent> fetchMovieDetail(MovieModel? movie);
  Future<MovieEvent> searchMovies(keyword);
}
