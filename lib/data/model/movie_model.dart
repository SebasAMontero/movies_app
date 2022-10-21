import '../../domain/entity/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required bool adult,
    required String backdropPath,
    required List<dynamic> genreIds,
    required int id,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required double popularity,
    required String posterPath,
    required String releaseDate,
    required String title,
    required bool video,
    required double voteAverage,
    required int voteCount,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          genreIds: genreIds,
          id: id,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          releaseDate: releaseDate,
          title: title,
          video: video,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  factory MovieModel.fromJson(dynamic moviesJson) {
    return MovieModel(
      adult: moviesJson['adult'],
      backdropPath: moviesJson['backdrop_path'],
      genreIds: moviesJson['genre_ids'],
      id: moviesJson['id'],
      originalLanguage: moviesJson['original_language'],
      originalTitle: moviesJson['original_title'],
      overview: moviesJson['overview'],
      popularity: moviesJson['popularity'],
      posterPath: moviesJson['poster_path'],
      releaseDate: moviesJson['release_date'],
      title: moviesJson['title'],
      video: moviesJson['video'],
      voteAverage: moviesJson['vote_average'].toDouble(),
      voteCount: moviesJson['vote_count'],
    );
  }

  static Map<String, dynamic> toJson(MovieModel movie) {
    return {
      'adult': movie.adult,
      'backdrop_path': movie.backdropPath,
      'genre_ids': movie.genreIds,
      'id': movie.id,
      'original_language': movie.originalLanguage,
      'original_title': movie.originalTitle,
      'overview': movie.overview,
      'popularity': movie.popularity,
      'poster_path': movie.posterPath,
      'release_date': movie.releaseDate,
      'title': movie.title,
      'video': movie.video,
      'vote_average': movie.voteAverage,
      'vote_count': movie.voteCount,
    };
  }
}
