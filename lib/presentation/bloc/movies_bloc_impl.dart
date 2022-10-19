import 'dart:async';

import '../../core/usecases/i_usecase.dart';
import '../../domain/entity/movie_event.dart';
import 'interfaces/i_movies_bloc.dart';

class MoviesBloc implements IMoviesBloc {
  final Usecase _getMoviesUsecase;
  final Usecase _searchMoviesUsecase;

  MoviesBloc(
    this._getMoviesUsecase,
    this._searchMoviesUsecase,
  );

  final StreamController<MovieEvent> _moviesStreamController =
      StreamController<MovieEvent>.broadcast();

  @override
  Stream<MovieEvent> getStream() => _moviesStreamController.stream;

  @override
  void initialize() {
    _moviesStreamController.sink.add(MovieEvent(status: Status.initial));
  }

  @override
  void dispose() {
    _moviesStreamController.close();
  }

  @override
  Future<void> getMovies(endpoint) async {
    _moviesStreamController.sink.add(
      MovieEvent(
        status: Status.loading,
      ),
    );
    _moviesStreamController.sink.add(await _getMoviesUsecase(params: endpoint));
  }

  @override
  Future<void> searchMovies(keyword) async {
    _moviesStreamController.sink.add(
      MovieEvent(
        status: Status.loading,
      ),
    );
    _moviesStreamController.sink.add(
      await _searchMoviesUsecase(params: keyword),
    );
  }
}
