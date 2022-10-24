import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import '../../core/util/keys.dart';
import '../../data/model/movie_model.dart';
import 'show_image.dart';

import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../view/movie_detail_screen.dart';

ListView buildMovieList(List<MovieModel> movieList) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: movieList.length,
    itemBuilder: (
      BuildContext context,
      int index,
    ) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (
                BuildContext context,
              ) =>
                  MovieDetailScreen(
                movie: movieList[index],
              ),
            ),
          );
        },
        child: Padding(
          key: Keys.movieListItemKey,
          padding: const EdgeInsets.all(Dimensions.movieContainerPadding),
          child: Container(
            color: Palette.containerColor,
            child: Padding(
              padding: const EdgeInsets.all(
                Dimensions.innerMovieContainerPadding,
              ),
              child: Row(
                children: [
                  showImgIfExists(
                    movieList[index].posterPath,
                    Dimensions.moviePosterSize,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      movieList[index].title,
                      style: const TextStyle(
                        color: Palette.lightFontColor,
                        fontSize: Dimensions.movieTitleFontSize,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: Dimensions.movieTitleMaxLines,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
