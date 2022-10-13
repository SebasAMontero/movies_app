import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/data/model/movie_model.dart';

import '../../mocks.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('MovieModel testing', () {
    test('MovieModel from Json instantiation', () {
      expect(MovieModel.fromJson(moviesJson), isInstanceOf<MovieModel>());
    });
    test('MovieModel caused by corrupted json', () {
      expect(
        () => MovieModel.fromJson(apiResponseCorruptedJson),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
