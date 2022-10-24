import '../../core/util/status_enum.dart';
import '../../data/model/movie_detail_model.dart';


class MovieDetailEvent {
  final Status status;
  final String? errorMessage;
  final MovieDetailModel? movie;

  MovieDetailEvent({
    required this.status,
    this.errorMessage,
    this.movie,
  });
}
