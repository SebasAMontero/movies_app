import '../../../core/bloc/i_bloc.dart';
import '../../../data/model/movie_model.dart';
import '../../../domain/entity/movie_detail_event.dart';
import '../../../domain/entity/movie_event.dart';

abstract class IMoviesBloc implements Bloc {
  @override
  void initialize();

  @override
  void dispose();

  Stream<MovieEvent> getStream();

  Future<void> getMovies(endpoint);

  Future<MovieDetailEvent> getSpecificMovie(MovieModel movie);
  Future<void> searchMovies(keyword);
}
