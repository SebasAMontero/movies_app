import '.secret_token.dart';

abstract class ServiceConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
    static const String movieUrl = '/movie/';
  static const Map<String, String> headers = {
    'Authorization': 'Bearer $bearerToken'
  };
  static const Map<String, String> endpoints = {
    'Top Rated': '/movie/top_rated',
    'Upcoming': '/movie/upcoming',
    'Now Playing': '/movie/now_playing',
  };

  static const topRatedCollection = 'top_rated';
  static const nowPlayingCollection = 'now_playing';
  static const upcomingCollection = 'upcoming';
  static const collectionDocumentModifier = '_doc';

  static const String imagePath = 'https://image.tmdb.org/t/p/original';
  static const String movieId = 'id';
}
