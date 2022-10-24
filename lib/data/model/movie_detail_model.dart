import 'genre_model.dart';
import 'movie_model.dart';
import 'production_countries_model.dart';

import 'collection_model.dart';
import 'production_companies_model.dart';

import '../../domain/entity/abstract_movie_detail.dart';
import 'spoken_languages_model.dart';

class MovieDetailModel extends AbstractMovieDetail {
  MovieDetailModel({
    required super.title,
    super.adult,
    super.backdropPath,
    super.genres,
    super.homepage,
    super.budget,
    super.imdbId,
    super.originalLanguage,
    super.originalTitle,
    super.overview,
    super.id,
    super.popularity,
    super.belongsToCollection,
    super.posterPath,
    super.productionCompanies,
    super.productionCountries,
    super.releaseDate,
    super.revenue,
    super.runtime,
    super.spokenLanguages,
    super.status,
    super.tagline,
    super.video,
    super.voteAverage,
    super.voteCount,
  });

  factory MovieDetailModel.fromModel(MovieModel movieModel) {
    return MovieDetailModel(
      adult: movieModel.adult,
      backdropPath: movieModel.backdropPath,
      id: movieModel.id,
      originalLanguage: movieModel.originalLanguage,
      originalTitle: movieModel.originalTitle,
      overview: movieModel.overview,
      popularity: movieModel.popularity,
      posterPath: movieModel.posterPath,
      releaseDate: movieModel.releaseDate,
      title: movieModel.title,
      video: movieModel.video,
      voteAverage: movieModel.voteAverage,
      voteCount: movieModel.voteCount,
    );
  }

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      title: json['title'] as String,
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      homepage: json['homepage'] as String?,
      imdbId: json['imdbId'] as String?,
      originalTitle: json['original_title'] as String?,
      originalLanguage: json['original_language'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      tagline: json['tagline'] as String?,
      status: json['status'] as String?,
      budget: json['budget'] as int?,
      revenue: json['revenue'] as int?,
      runtime: json['runtime'] as int?,
      id: json['id'] as int?,
      voteCount: json['vote_count'] as int?,
      video: json['video'] as bool?,
      voteAverage: json['vote_average'] as double?,
      popularity: json['popularity'] as double?,
      productionCompanies:
          ProductionCompaniesModel.fromList(json['production_companies']),
      productionCountries:
          ProductionCountriesModel.fromList(json['production_countries']),
      spokenLanguages: SpokenLanguagesModel.fromList(json['spoken_languages']),
      belongsToCollection:
          CollectionModel.fromMap(json['belongs_to_collection']),
      genres: GenreModel.fromList(json['genres']),
    );
  }

  List<String> getSpokenLanguages() {
    if (spokenLanguages == null) return [];
    List<String> listOfLanguages = [];
    listOfLanguages.addAll(
      spokenLanguages!.map(
        (language) => language.toString(),
      ),
    );
    return listOfLanguages;
  }

  List<String> getProductionCountries() {
    if (productionCountries == null) return [];
    List<String> listOfCountries = [];
    listOfCountries.addAll(
      productionCountries!.map(
        (country) => country.toString(),
      ),
    );
    return listOfCountries;
  }

  List<String> getProductionCompanies() {
    if (productionCompanies == null) return [];
    List<String> listOfCompanies = [];
    listOfCompanies.addAll(
      productionCompanies!.map(
            (company) => company.toString(),
      ),
    );
    return listOfCompanies;
  }
}
