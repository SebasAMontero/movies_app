import 'package:movies_app/core/util/status_enum.dart';
import 'package:movies_app/data/model/movie_detail_model.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/domain/entity/movie_detail_event.dart';
import 'package:movies_app/domain/entity/movie_event.dart';

final apiResponseJson = {
  'page': 1,
  'results': [
    {
      'adult': false,
      'backdrop_path': '/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg',
      'genre_ids': [18, 80],
      'id': 238,
      'original_language': 'en',
      'original_title': 'The Godfather',
      'overview':
          'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.',
      'popularity': 111.98,
      'poster_path': '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
      'release_date': '1972-03-14',
      'title': 'The Godfather',
      'video': false,
      'vote_average': 8.7,
      'vote_count': 16756
    },
  ],
  'total_pages': 521,
  'total_results': 10419
};
const movieDetailId = 436270;
final movieDetailJson = {
  'adult': false,
  'backdrop_path': '/d6MhreFdMHONqX3iZlJGCF8UkIt.jpg',
  'belongs_to_collection': null,
  'budget': 200000000,
  'genres': [
    {'id': 28, 'name': 'Action'},
    {'id': 12, 'name': 'Adventure'},
    {'id': 14, 'name': 'Fantasy'}
  ],
  'homepage': 'https://www.dc.com/BlackAdam',
  'id': 436270,
  'imdb_id': 'tt6443346',
  'original_language': 'en',
  'original_title': 'Black Adam',
  'overview':
      'Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.',
  'popularity': 4416.78,
  'poster_path': '/3zXceNTtyj5FLjwQXuPvLYK5YYL.jpg',
  'production_companies': [
    {
      'id': 12,
      'logo_path': '/iaYpEp3LQmb8AfAtmTvpqd4149c.png',
      'name': 'New Line Cinema',
      'origin_country': 'US'
    },
    {
      'id': 34081,
      'logo_path': null,
      'name': 'Flynn Picture Company',
      'origin_country': 'US'
    },
    {
      'id': 73669,
      'logo_path': '/7tmSGstK3KwgcDIuBYLTAayjit9.png',
      'name': 'Seven Bucks Productions',
      'origin_country': 'US'
    },
    {
      'id': 128064,
      'logo_path': '/13F3Jf7EFAcREU0xzZqJnVnyGXu.png',
      'name': 'DC Films',
      'origin_country': 'US'
    }
  ],
  'production_countries': [
    {'iso_3166_1': 'US', 'name': 'United States of America'}
  ],
  'release_date': '2022-10-19',
  'revenue': 140000000,
  'runtime': 125,
  'spoken_languages': [
    {'english_name': 'English', 'iso_639_1': 'en', 'name': 'English'}
  ],
  'status': 'Released',
  'tagline': 'The world needed a hero. It got Black Adam.',
  'title': 'Black Adam',
  'video': false,
  'vote_average': 7.119,
  'vote_count': 515
};
final movieDetailCorruptedJson = {
  'adult': 14,
  'backdrop_path': '/d6MhreFdMHONqX3iZlJGCF8UkIt.jpg',
  'belongs_to_collection': null,
  'budget': '200000000',
  'genres': [
    {'id': 28, 'name': 'Action'},
    {'id': 12, 'name': 'Adventure'},
    {'id': 14, 'name': 'Fantasy'}
  ],
  'homepage': 'https://www.dc.com/BlackAdam',
  'id': true,
  'imdb_id': 'tt6443346',
  'original_language': 'en',
  'original_title': 'Black Adam',
  'overview':
      'Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.',
  'popularity': 4416.78,
  'poster_path': '/3zXceNTtyj5FLjwQXuPvLYK5YYL.jpg',
  'production_companies': [
    {
      'id': 12,
      'logo_path': '/iaYpEp3LQmb8AfAtmTvpqd4149c.png',
      'name': 'New Line Cinema',
      'origin_country': 'US'
    },
    {
      'id': 34081,
      'logo_path': null,
      'name': 'Flynn Picture Company',
      'origin_country': 'US'
    },
    {
      'id': 73669,
      'logo_path': '/7tmSGstK3KwgcDIuBYLTAayjit9.png',
      'name': 'Seven Bucks Productions',
      'origin_country': 'US'
    },
    {
      'id': 128064,
      'logo_path': '/13F3Jf7EFAcREU0xzZqJnVnyGXu.png',
      'name': 'DC Films',
      'origin_country': 'US'
    }
  ],
  'production_countries': [
    {'iso_3166_1': 'US', 'name': 'United States of America'}
  ],
  'release_date': '2022-10-19',
  'revenue': 140000000,
  'runtime': 125,
  'spoken_languages': [
    {'english_name': 'English', 'iso_639_1': 'en', 'name': 'English'}
  ],
  'status': 'Released',
  'tagline': 'The world needed a hero. It got Black Adam.',
  'title': 'Black Adam',
  'video': false,
  'vote_average': 7.119,
  'vote_count': 515
};

final MovieModel movieModelMock = MovieModel.fromJson(moviesJson);
final MovieDetailModel movieDetailModelMock =
    MovieDetailModel.fromJson(movieDetailJson);

final MovieEvent movieEventMock =
    MovieEvent(movies: [movieModelMock], status: Status.success);
final MovieDetailEvent movieDetailEventMock =
    MovieDetailEvent(status: Status.success, movie: movieDetailModelMock);
final moviesJson = {
  'adult': false,
  'backdrop_path': '/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg',
  'genre_ids': [18, 80],
  'id': 238,
  'original_language': 'en',
  'original_title': 'The Godfather',
  'overview':
      'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.',
  'popularity': 111.98,
  'poster_path': '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
  'release_date': '1972-03-14',
  'title': 'The Godfather',
  'video': false,
  'vote_average': 8.7,
  'vote_count': 16756
};

final apiResponseCorruptedJson = {
  'page': 1,
  'results': [
    {
      'adult': 1,
      'backdrop_path': '/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg',
      'genre_ids': [18, 80],
      'id': 238,
      'original_language': 'en',
      'original_title': 'The Godfather',
      'overview':
          'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.',
      'popularity': 111.98,
      'poster_path': '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
      'release_date': '1972-03-14',
      'title': 'The Godfather',
      'video': false,
      'vote_average': 8.7,
      'vote_count': 16756
    },
  ],
  'total_pages': 521,
  'total_results': 10419
};

final movieDetailedJson = {
  'adult': false,
  'backdrop_path': '/lPYts3qpBDMlJaGjzd7nA5Piyd2.jpg',
  'belongs_to_collection': null,
  'budget': 0,
  'genres': [
    {'id': 12, 'name': 'Adventure'},
    {'id': 18, 'name': 'Drama'},
    {'id': 14, 'name': 'Fantasy'},
    {'id': 10751, 'name': 'Family'}
  ],
  'homepage': '',
  'id': 271,
  'imdb_id': 'tt0088015',
  'original_language': 'sv',
  'original_title': 'Ronja Rövardotter',
  'overview':
      "Ronya lives happily in her father's castle until she comes across a new playmate, Birk, in the nearby dark forest. The two explore the wilderness, braving dangerous Witchbirds and Rump-Gnomes. But when their families find out Birk and Ronja have been playing together, they forbid them to see each other again. Indeed, their fathers are competing robber chieftains and bitter enemies. Now the two spunky children must try to tear down the barriers that have kept their families apart for so long.",
  'popularity': 16.746,
  'poster_path': '/gatMa1qfwpJqiawPjJxodUvdB0.jpg',
  'production_companies': [
    {
      'id': 113,
      'logo_path': null,
      'name': 'Svenska Ord',
      'origin_country': 'SE'
    },
    {
      'id': 115,
      'logo_path': null,
      'name': 'FilmTeknik',
      'origin_country': 'SE'
    },
    {
      'id': 2999,
      'logo_path': '/zGSqFee9aDgDuLD6vcs2mcJUem4.png',
      'name': 'SVT',
      'origin_country': 'SE'
    },
    {
      'id': 6181,
      'logo_path': '/eaQ7or8IoEmPfgmQiU2C5lVZkxS.png',
      'name': 'SF Studios',
      'origin_country': 'SE'
    },
    {
      'id': 12984,
      'logo_path': null,
      'name': 'Norsk Film',
      'origin_country': 'NO'
    }
  ],
  'production_countries': [
    {'iso_3166_1': 'SE', 'name': 'Sweden'},
    {'iso_3166_1': 'NO', 'name': 'Norway'}
  ],
  'release_date': '1984-12-14',
  'revenue': 0,
  'runtime': 126,
  'spoken_languages': [
    {'english_name': 'Swedish', 'iso_639_1': 'sv', 'name': 'svenska'}
  ],
  'status': 'Released',
  'tagline': '',
  'title': "Ronia, The Robber's Daughter",
  'video': false,
  'vote_average': 6.87,
  'vote_count': 146
};

final detailedMovieJson = {
  'adult': false,
  'backdrop_path': '/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg',
  'belongs_to_collection': {
    'id': 230,
    'name': 'The Godfather Collection',
    'poster_path': '/9Baumh5J9N1nJUYzNkm0xsgjpwY.jpg',
    'backdrop_path': '/3WZTxpgscsmoUk81TuECXdFOD0R.jpg'
  },
  'budget': 6000000,
  'genres': [
    {
      'id': 18,
      'name': 'Drama'
    },
    {
      'id': 80,
      'name': 'Crime'
    }
  ],
  'homepage': 'http://www.thegodfather.com/',
  'id': 238,
  'imdb_id': 'tt0068646',
  'original_language': 'en',
  'original_title': 'The Godfather',
  'overview': 'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.',
  'popularity': 120.31,
  'poster_path': '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
  'production_companies': [
    {
      'id': 4,
      'logo_path': '/gz66EfNoYPqHTYI4q9UEN4CbHRc.png',
      'name': 'Paramount',
      'origin_country': 'US'
    },
    {
      'id': 10211,
      'logo_path': null,
      'name': 'Alfran Productions',
      'origin_country': 'US'
    }
  ],
  'production_countries': [
    {
      'iso_3166_1': 'US',
      'name': 'United States of America'
    }
  ],
  'release_date': '1972-03-14',
  'revenue': 245066411,
  'runtime': 175,
  'spoken_languages': [
    {
      'english_name': 'English',
      'iso_639_1': 'en',
      'name': 'English'
    },
    {
      'english_name': 'Italian',
      'iso_639_1': 'it',
      'name': 'Italiano'
    },
    {
      'english_name': 'Latin',
      'iso_639_1': 'la',
      'name': 'Latin'
    }
  ],
  'status': 'Released',
  'tagline': "An offer you can't refuse.",
  'title': 'The Godfather',
  'video': false,
  'vote_average': 8.716,
  'vote_count': 16831
};