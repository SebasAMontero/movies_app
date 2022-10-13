import '../../../core/bloc/i_bloc.dart';
import '../../../domain/entity/movie_event.dart';

abstract class IMoviesBloc implements Bloc {
  @override
  void initialize();
  @override
  void dispose();
  Stream<MovieEvent> getStream();
  Future<void> getMovies(endpoint);
}
