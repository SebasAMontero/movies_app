import 'dart:convert';
import 'dart:io';

import '../../core/util/status_enum.dart';
import '../../domain/entity/movie_detail_event.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/movie_event.dart';
import '../../domain/repository/database_response.dart';
import '../../domain/repository/i_movies_repository.dart';
import '../../presentation/bloc/interfaces/i_connection_bloc.dart';
import '../datasource/local/DAOs/database.dart';
import '../datasource/remote/api_service.dart';
import '../model/movie_detail_model.dart';
import '../model/movie_model.dart';

class MoviesRepository with DatabaseResponse implements IMoviesRepository {
  final ApiService _service;
  final Database _db;
  final IConnectionBloc _connectionBloc;

  MoviesRepository(
    this._service,
    this._db,
    this._connectionBloc,
  );

  @override
  Database get database => _db;

  @override
  Future<MovieEvent> searchMovies(keyword) async {
    return searchByKeyword(
      keyword: keyword,
    );
  }

  @override
  Future<MovieEvent> fetchMovies(endpoint) async {
    List<MovieModel> moviesList = [];
    int startIndex = endpoint.lastIndexOf('/');
    String document = endpoint.substring(startIndex + 1) + '_doc';
    String subCollection = endpoint.substring(startIndex + 1);
    if (_connectionBloc.isOnline) {
      try {
        var apiResponse = await _service.apiCall(endpoint: endpoint);
        if (apiResponse.statusCode == HttpStatus.ok) {
          List<dynamic> movies = json
              .decode(apiResponse.body)[StringConstants.responseResultField];

          if (movies.isEmpty) {
            return MovieEvent(status: Status.empty);
          } else {
            movies.forEach((movie) {
              (movie as Map<String, dynamic>)[
                      StringConstants.loweCaseTitleField] =
                  (movie['title'] as String).toLowerCase();
              moviesList.add(MovieModel.fromJson(movie));
            });
            _db.addMovies(
              movies: movies,
              mainCollectionDocument: document,
              subCollection: subCollection,
            );
            return MovieEvent(
              movies: moviesList,
              status: Status.success,
            );
          }
        }
        return getMoviesFromDatabase(
          document: document,
          subCollection: subCollection,
        );
      } catch (e) {
        return getMoviesFromDatabase(
          document: document,
          subCollection: subCollection,
        );
      }
    } else {
      return getMoviesFromDatabase(
        document: document,
        subCollection: subCollection,
      );
    }
  }

  @override
  Future<MovieDetailEvent> fetchMovieDetail(MovieModel? movie) async {
    if (_connectionBloc.isOnline) {
      try {
        var apiResponse = await _service.apiCallMovieId(
          id: movie?.id.toString(),
        );

        if (apiResponse.statusCode == HttpStatus.ok) {
          Map<String, dynamic> movieDetail = json.decode(apiResponse.body);

          _db.addMovieDetail(
            movie: movieDetail,
          );
          MovieDetailModel movieDetailComplete =
              MovieDetailModel.fromJson(movieDetail);

          return MovieDetailEvent(
            movie: movieDetailComplete,
            status: Status.success,
          );
        }
        return getMovieDetailFromDatabase(
          movie: movie!,
        );
      } catch (e) {
        return getMovieDetailFromDatabase(
          movie: movie!,
        );
      }
    } else {
      return getMovieDetailFromDatabase(
        movie: movie!,
      );
    }
  }
}
