import '../../data/model/collection_model.dart';
import '../../data/model/genre_model.dart';
import '../../data/model/production_companies_model.dart';
import '../../data/model/production_countries_model.dart';
import '../../data/model/spoken_languages_model.dart';

abstract class AbstractMovieDetail {
  AbstractMovieDetail({
    required this.title,
    this.adult,
    this.backdropPath,
    this.genres,
    this.homepage,
    this.budget,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.id,
    this.popularity,
    this.belongsToCollection,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  String? backdropPath;
  String? homepage;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? status;
  String? tagline;
  String title;

  double? popularity;
  double? voteAverage;

  bool? adult;
  bool? video;

  int? budget;
  int? id;
  int? revenue;
  int? runtime;
  int? voteCount;

  List<GenreModel?>? genres;
  List<ProductionCompaniesModel?>? productionCompanies;
  List<ProductionCountriesModel?>? productionCountries;
  List<SpokenLanguagesModel?>? spokenLanguages;
  CollectionModel? belongsToCollection;
}
