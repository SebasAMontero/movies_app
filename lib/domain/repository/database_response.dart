import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/datasource/local/DAOs/database.dart';
import '../../data/model/movie_model.dart';
import '../entity/movie_event.dart';

mixin DatabaseResponse {
  Database get database;

  Future<MovieEvent> getMoviesFromDatabase({
    required String document,
    required String subcollection,
  }) async {
    List<MovieModel> moviesList = [];
    try {
      QuerySnapshot dbResponse = await database.readMovies(
        mainCollectionDocument: document,
        subcollection: subcollection,
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
}
