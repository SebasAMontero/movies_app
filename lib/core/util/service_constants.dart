import '.secret_token.dart';

abstract class ServiceConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const Map<String, String> headers = {
    'Authorization' : 'Bearer $bearerToken'
  };
  static const Map<String, String> endpoints = {
    'Top Rated' : '/movie/top_rated',
    'Upcoming' : '/movie/upcoming',
    'Now Playing' : '/movie/now_playing',
  };
  static const String imagePath = 'https://image.tmdb.org/t/p/original';
}
