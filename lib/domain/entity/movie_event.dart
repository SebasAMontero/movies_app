import '../../core/util/status_enum.dart';

import '../../data/model/movie_model.dart';

class MovieEvent {
  final List<MovieModel>? movies;
  final Status status;
  final String? errorMessage;

  MovieEvent({
    this.movies,
    required this.status,
    this.errorMessage,
  });
}
