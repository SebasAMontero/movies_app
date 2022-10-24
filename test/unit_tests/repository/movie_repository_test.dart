import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/core/util/service_constants.dart';
import 'package:movies_app/data/datasource/local/DAOs/database.dart';
import 'package:movies_app/data/datasource/remote/api_service.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/movies_repository_impl.dart';
import 'package:movies_app/domain/entity/movie_detail_event.dart';
import 'package:movies_app/domain/entity/movie_event.dart';
import 'package:movies_app/domain/repository/i_movies_repository.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/presentation/bloc/interfaces/i_connection_bloc.dart';

import '../../mocks.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([ApiService, Database, IConnectionBloc])
void main() {
  late MockApiService service;
  late IMoviesRepository moviesRepository;
  late Database database;
  late IConnectionBloc connectionBloc;
  final String? endpoint = ServiceConstants.endpoints['Top Rated'];
  final MovieModel movieModel = MovieModel.fromJson(moviesJson);

  setUpAll(() {
    service = MockApiService();
    database = MockDatabase();
    connectionBloc = MockIConnectionBloc();
    moviesRepository = MoviesRepository(
      service,
      database,
      connectionBloc,
    );
  });

  group('Movies Repository Unit Testing', () {
    test('Test MoviesRepository fetchMovies', () async {
      when(
        service.apiCall(
          endpoint: endpoint,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(apiResponseJson),
          HttpStatus.ok,
        );
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovies(
          endpoint,
        ),
        isA<MovieEvent>(),
      );
    });
    test('Test MoviesRepository fetchMovieDetail', () async {
      when(
        service.apiCallMovieId(
          id: movieDetailId,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(movieDetailJson),
          HttpStatus.ok,
        );
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovieDetail(
          movieModel,
        ),
        isA<MovieDetailEvent>(),
      );
    });

    test('Test MoviesRepository empty json', () async {
      when(service.apiCall(endpoint: endpoint)).thenAnswer((_) async {
        return http.Response(
          jsonEncode({}),
          HttpStatus.ok,
        );
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovies(
          endpoint,
        ),
        isA<MovieEvent>(),
      );
    });
    test('Test fetchMovieDetail with empty json', () async {
      when(
        service.apiCallMovieId(
          id: movieDetailId,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode({}),
          HttpStatus.ok,
        );
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovieDetail(
          movieModel,
        ),
        isA<MovieDetailEvent>(),
      );
    });

    test('Test MoviesRepository corrupted json', () async {
      when(
        service.apiCall(
          endpoint: endpoint,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(apiResponseCorruptedJson),
          HttpStatus.ok,
        );
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovies(
          endpoint,
        ),
        isA<MovieEvent>(),
      );
    });

    test('Test MoviesRepository no internet connection', () async {
      when(service.apiCall(endpoint: endpoint)).thenAnswer((_) async {
        return http.Response('', HttpStatus.badGateway);
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovies(endpoint),
        isA<MovieEvent>(),
      );
    });
    test('Test fetchMovieDetail no internet connection', () async {
      when(
        service.apiCallMovieId(
          id: movieDetailId,
        ),
      ).thenAnswer((_) async {
        return http.Response('', HttpStatus.badGateway);
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovieDetail(
          movieModel,
        ),
        isA<MovieDetailEvent>(),
      );
    });

    test('Test MoviesRepository bad request', () async {
      when(
        service.apiCall(
          endpoint: endpoint,
        ),
      ).thenAnswer((_) async {
        return http.Response('', HttpStatus.badGateway);
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovies(
          endpoint,
        ),
        isA<MovieEvent>(),
      );
    });
    test('Test fetchMovieDetail bad request', () async {
      when(
        service.apiCallMovieId(
          id: movieDetailId,
        ),
      ).thenAnswer((_) async {
        return http.Response('', HttpStatus.badGateway);
      });
      when(connectionBloc.isOnline).thenAnswer((_) {
        return true;
      });
      expect(
        await moviesRepository.fetchMovieDetail(
          movieModel,
        ),
        isA<MovieDetailEvent>(),
      );
    });
  });
}
