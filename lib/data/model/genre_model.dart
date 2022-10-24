import '../../domain/entity/abstract_genre.dart';

class GenreModel extends AbstractGenre {
  GenreModel({
    super.id,
    super.name,
  });

  static List<GenreModel> fromList(
    List<dynamic>? genreList,
  ) {
    List<GenreModel> genres = [];
    if (genreList != null) {
      genreList.forEach((genre) {
        genres.add(GenreModel.fromJson(genre));
      });
    }
    return genres;
  }

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}
