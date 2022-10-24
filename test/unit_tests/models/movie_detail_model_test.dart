import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/data/model/movie_detail_model.dart';

import '../../mocks.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('MovieDetailModel testing', () {
    test('Try creating a MovieDetailModel from Json ', () {
      expect(
        MovieDetailModel.fromJson(movieDetailJson),
        isInstanceOf<MovieDetailModel>(),
      );
    });
    test('Try creating a MovieDetailModel from a corrupted Json', () {
      expect(
        () => MovieDetailModel.fromJson(apiResponseCorruptedJson),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
