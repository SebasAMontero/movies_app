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

enum Status {
  initial,
  loading,
  success,
  empty,
  error,
}
