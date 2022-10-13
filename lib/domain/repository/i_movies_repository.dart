import '../entity/movie_event.dart';

abstract class IMoviesRepository {
  Future<MovieEvent> fetchMovies(endpoint);
}
