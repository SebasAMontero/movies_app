import 'dart:async';

import '../../core/usecases/i_usecase.dart';

import '../../core/util/status_enum.dart';

import '../../domain/entity/movie_detail_event.dart';
import '../../domain/entity/movie_event.dart';
import 'interfaces/i_movies_bloc.dart';

class MoviesBloc implements IMoviesBloc {
  final UseCase _getMoviesUseCase;
  final UseCase _getMovieDetailUseCase;

  final UseCase _searchMoviesUsecase;

  MoviesBloc(
    this._getMoviesUseCase,
    this._getMovieDetailUseCase,
    this._searchMoviesUsecase,
  );

  final StreamController<MovieEvent> _moviesStreamController =
      StreamController<MovieEvent>.broadcast();

  @override
  Stream<MovieEvent> getStream() => _moviesStreamController.stream;

  @override
  void initialize() {
    _moviesStreamController.sink.add(
      MovieEvent(status: Status.initial),
    );
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
    _moviesStreamController.sink.add(await _getMoviesUseCase(params: endpoint));
  }

  @override
  Future<MovieDetailEvent> getSpecificMovie(movie) async {
    return await _getMovieDetailUseCase(params: movie);
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
