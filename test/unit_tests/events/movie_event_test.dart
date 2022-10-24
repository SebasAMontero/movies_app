import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/util/status_enum.dart';
import 'package:movies_app/domain/entity/movie_event.dart';

void main() {
  late MovieEvent movieEvent;

  setUp(() {
    movieEvent = MovieEvent(status: Status.initial);
  });

  group('Movie Event Unit Testing', () {
    test('Movie Event Correct Instantiation Test', () {
      expect(
        movieEvent,
        isInstanceOf<MovieEvent>(),
      );
    });
  });
}
