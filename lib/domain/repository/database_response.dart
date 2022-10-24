import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/util/status_enum.dart';
import '../../data/datasource/local/DAOs/database.dart';
import '../../data/model/movie_detail_model.dart';
import '../../data/model/movie_model.dart';
import '../entity/movie_detail_event.dart';
import '../entity/movie_event.dart';

mixin DatabaseResponse {
  Database get database;

  Future<MovieEvent> getMoviesFromDatabase({
    required String document,
    required String subCollection,
  }) async {
    List<MovieModel> moviesList = [];
    try {
      QuerySnapshot dbResponse = await database.readMovies(
        mainCollectionDocument: document,
        subCollection: subCollection,
      );
      if (dbResponse.docs.isEmpty) {
        return MovieEvent(status: Status.empty);
      } else {
        List<QueryDocumentSnapshot> movies = dbResponse.docs;
        movies.forEach((movie) {
          moviesList.add(MovieModel.fromJson(movie));
        });
        return MovieEvent(
          movies: moviesList,
          status: Status.success,
        );
      }
    } catch (e) {
      return MovieEvent(
        status: Status.error,
        errorMessage: '$e',
      );
    }
  }

  Future<MovieDetailEvent> getMovieDetailFromDatabase({
    required MovieModel movie,
  }) async {
    late MovieDetailModel movieDetail;
    try {
      DocumentSnapshot dbResponse = await database.readMovieDetail(
        id: movie.id.toString(),
      );

      Map<String, dynamic> movieResponse =
          dbResponse.data() as Map<String, dynamic>;

      movieDetail = MovieDetailModel.fromJson(movieResponse);

      return MovieDetailEvent(
        movie: movieDetail,
        status: Status.success,
      );
    } catch (e) {
      return MovieDetailEvent(
        status: Status.success,
        movie: MovieDetailModel.fromModel(movie),
      );
    }
  }

  Future<MovieEvent> searchByKeyword({required String keyword}) async {
    Set<MovieModel> moviesList = {};
    try {
      List<QuerySnapshot> dbResponse =
          await database.searchMovies(keyword: keyword);
      bool resultsAreEmpty = true;
      dbResponse.forEach((collection) {
        if (collection.docs.isNotEmpty) {
          resultsAreEmpty = false;
        }
      });
      if (resultsAreEmpty) {
        return MovieEvent(status: Status.empty);
      }
      List<QueryDocumentSnapshot> movies = [];
      dbResponse.forEach((searchResult) {
        movies.addAll(searchResult.docs);
      });
      movies.forEach((movie) {
        moviesList.add(
          MovieModel.fromJson(movie),
        );
      });
      return MovieEvent(
        movies: moviesList.toList(),
        status: Status.success,
      );
    } catch (e) {
      return MovieEvent(
        status: Status.error,
        errorMessage: '$e',
      );
    }
  }
}
