// Mocks generated by Mockito 5.3.2 from annotations
// in movies_app/test/widget_tests/upcoming_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movies_app/data/model/movie_model.dart' as _i6;
import 'package:movies_app/domain/entity/movie_detail_event.dart' as _i2;
import 'package:movies_app/domain/entity/movie_event.dart' as _i5;
import 'package:movies_app/presentation/bloc/interfaces/i_movies_bloc.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMovieDetailEvent_0 extends _i1.SmartFake
    implements _i2.MovieDetailEvent {
  _FakeMovieDetailEvent_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IMoviesBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockIMoviesBloc extends _i1.Mock implements _i3.IMoviesBloc {
  MockIMoviesBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void initialize() => super.noSuchMethod(
        Invocation.method(
          #initialize,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Stream<_i5.MovieEvent> getStream() => (super.noSuchMethod(
        Invocation.method(
          #getStream,
          [],
        ),
        returnValue: _i4.Stream<_i5.MovieEvent>.empty(),
      ) as _i4.Stream<_i5.MovieEvent>);
  @override
  _i4.Future<void> getMovies(dynamic endpoint) => (super.noSuchMethod(
        Invocation.method(
          #getMovies,
          [endpoint],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i2.MovieDetailEvent> getSpecificMovie(_i6.MovieModel? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSpecificMovie,
          [movie],
        ),
        returnValue:
            _i4.Future<_i2.MovieDetailEvent>.value(_FakeMovieDetailEvent_0(
          this,
          Invocation.method(
            #getSpecificMovie,
            [movie],
          ),
        )),
      ) as _i4.Future<_i2.MovieDetailEvent>);
  @override
  _i4.Future<void> searchMovies(dynamic keyword) => (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [keyword],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
