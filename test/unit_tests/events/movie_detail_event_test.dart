import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/util/status_enum.dart';
import 'package:movies_app/domain/entity/movie_detail_event.dart';

void main() {
  late MovieDetailEvent movieDetailEvent;

  setUp(() {
    movieDetailEvent = MovieDetailEvent(status: Status.initial);
  });

  group('Movie Event Unit Testing', () {
    test('Movie Event Correct Instantiation Test', () {
      expect(
        movieDetailEvent,
        isInstanceOf<MovieDetailEvent>(),
      );
    });
  });
}
