import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/domain/entity/movie.dart';

void main() {
  late Movie movie;

  setUp(() {
    movie = Movie(
      adult: false,
      backdropPath: '/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg',
      genreIds: [18, 80],
      id: 238,
      originalLanguage: 'en',
      originalTitle: 'The Godfather',
      overview:
          'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps to take care of the would-be killers, launching a campaign of bloody revenge.',
      popularity: 111.98,
      posterPath: '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
      releaseDate: '1972-03-14',
      title: 'The Godfather',
      lowerCaseTitle: 'the godfather',
      video: false,
      voteAverage: 8.7,
      voteCount: 16756,
    );
  });

  group('Card class testing', () {
    test('Card creation testing', () {
      expect(
        movie,
        isInstanceOf<Movie>(),
      );
    });
  });
}
