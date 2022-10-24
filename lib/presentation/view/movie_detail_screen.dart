import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/util/assets_constants.dart';
import '../../core/util/service_constants.dart';
import '../../data/model/movie_model.dart';
import '../widget/collection.dart';
import '../widget/show_image.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../../core/util/status_enum.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/movie_detail_event.dart';
import '../bloc/interfaces/i_movies_bloc.dart';
import '../widget/empty_widget.dart';
import '../widget/error_widget.dart';
import '../widget/visibility/visibility_list_attributes_name.dart';
import '../widget/visibility/visibility_list_of_string.dart';
import '../widget/visibility/visibility_text.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetailEvent> movieDetailFuture;

  @override
  void initState() {
    Provider.of<IMoviesBloc>(
      context,
      listen: false,
    ).getSpecificMovie(
      widget.movie,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.background,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: Dimensions.movieDetailExpandedHeight,
              backgroundColor: Palette.primary,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.movie.title,
                ),
                background: CachedNetworkImage(
                  imageUrl:
                      '${ServiceConstants.imagePath}${widget.movie.backdropPath}',
                  imageBuilder: (
                    BuildContext context,
                    ImageProvider img,
                  ) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: img,
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                          ),
                        )
                      ],
                    );
                  },
                  progressIndicatorBuilder: (
                    context,
                    url,
                    downloadProgress,
                  ) =>
                      SizedBox(
                    height: Dimensions.loaderBoxHeight,
                    width: Dimensions.loaderBoxWidth,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Palette.primaryLight,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (
                    context,
                    url,
                    error,
                  ) =>
                      Image.asset(
                    AssetsConstants.pathToNoRecordingImg,
                    height: Dimensions.assetImageDimension,
                    width: Dimensions.assetImageDimension,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    color: Palette.background,
                    constraints: const BoxConstraints(
                      minHeight: Dimensions.movieDetailScreenBoxConstraints,
                    ),
                    child: FutureBuilder<MovieDetailEvent>(
                      future:
                          Provider.of<IMoviesBloc>(context).getSpecificMovie(
                        widget.movie,
                      ),
                      initialData: MovieDetailEvent(status: Status.loading),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<MovieDetailEvent> snapshot,
                      ) {
                        switch (snapshot.data!.status) {
                          case Status.loading:
                            return const SizedBox(
                              height: Dimensions.loaderBoxHeight,
                              width: Dimensions.loaderBoxWidth,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Palette.primaryLight,
                                  ),
                                ),
                              ),
                            );
                          case Status.empty:
                            return empty();
                          case Status.success:
                            return ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(
                                    Dimensions
                                        .movieDetailScreenSliverListMargin,
                                  ),
                                  height:
                                      Dimensions.movieDetailScreenImageHeight,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Palette.background,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: Dimensions
                                            .movieDetailScreenSliverListBoxShadowBlur,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(
                                      Dimensions
                                          .movieDetailScreenSliverListBorderRadius,
                                    ),
                                    border: Border.all(
                                      width: Dimensions
                                          .movieDetailScreenSliverListBorderWidth,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Hero(
                                    tag:
                                        '${StringConstants.heroWidgetTag}${snapshot.data!.movie!.id}',
                                    child: showImgIfExists(
                                      snapshot.data!.movie!.posterPath!,
                                      Dimensions.moviePosterSize,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.detailScreenPadding,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.movieTitle} ${snapshot.data!.movie!.title}',
                                        isVisible:
                                            snapshot.data!.movie?.title != null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.status} ${snapshot.data!.movie!.status}',
                                        isVisible:
                                            snapshot.data!.movie?.status !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.originalTitle} ${snapshot.data!.movie!.originalTitle}',
                                        isVisible: snapshot
                                                .data!.movie?.originalTitle !=
                                            null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.revenue} ${snapshot.data!.movie!.revenue}',
                                        isVisible:
                                            snapshot.data!.movie?.revenue !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.releaseDate} ${snapshot.data!.movie!.releaseDate}',
                                        isVisible:
                                            snapshot.data!.movie?.releaseDate !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.voteCount} ${snapshot.data!.movie!.voteCount}',
                                        isVisible:
                                            snapshot.data!.movie?.voteCount !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.voteAverage} ${snapshot.data!.movie!.voteAverage}',
                                        isVisible:
                                            snapshot.data!.movie?.voteAverage !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.video} ${snapshot.data!.movie!.video}',
                                        isVisible:
                                            snapshot.data!.movie?.video != null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.tagline} ${snapshot.data!.movie!.tagline}',
                                        isVisible:
                                            snapshot.data!.movie?.tagline !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.runtime} ${snapshot.data!.movie!.runtime}',
                                        isVisible:
                                            snapshot.data!.movie?.runtime !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.popularity} ${snapshot.data!.movie!.popularity}',
                                        isVisible:
                                            snapshot.data!.movie?.popularity !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.originalLanguage} ${snapshot.data!.movie!.originalLanguage}',
                                        isVisible: snapshot.data!.movie
                                                ?.originalLanguage !=
                                            null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.budget} ${snapshot.data!.movie!.budget}',
                                        isVisible:
                                            snapshot.data!.movie?.budget !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.homepage} ${snapshot.data!.movie!.homepage}',
                                        isVisible:
                                            snapshot.data!.movie?.homepage !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.adult} ${snapshot.data!.movie!.adult}',
                                        isVisible:
                                            snapshot.data!.movie?.adult != null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.imdbId} ${snapshot.data!.movie!.imdbId}',
                                        isVisible:
                                            snapshot.data!.movie?.imdbId !=
                                                null,
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            '${StringConstants.overview} ${snapshot.data!.movie!.overview}',
                                        isVisible:
                                            snapshot.data!.movie?.overview !=
                                                null,
                                      ),
                                      Column(
                                        children: [
                                          VisibilityText(
                                            movieAttribute: StringConstants
                                                .productionCompanies,
                                            isVisible: snapshot.data!.movie
                                                    ?.productionCompanies !=
                                                null,
                                          ),
                                          VisibilityListOfString(
                                            listOfStrings: snapshot.data!.movie!
                                                .getProductionCompanies(),
                                            isVisible: snapshot.data!.movie
                                                    ?.productionCompanies !=
                                                null,
                                            hasBackground: true,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          VisibilityText(
                                            movieAttribute: StringConstants
                                                .productionCountries,
                                            isVisible: snapshot.data!.movie
                                                    ?.productionCountries !=
                                                null,
                                          ),
                                          VisibilityListOfString(
                                            isVisible: snapshot.data!.movie
                                                    ?.productionCountries !=
                                                null,
                                            listOfStrings: snapshot.data!.movie!
                                                .getProductionCountries(),
                                          ),
                                        ],
                                      ),
                                      VisibilityText(
                                        movieAttribute:
                                            StringConstants.spokenLanguages,
                                        isVisible: snapshot
                                                .data!.movie?.spokenLanguages !=
                                            null,
                                      ),
                                      VisibilityListOfString(
                                        isVisible: snapshot
                                                .data!.movie?.spokenLanguages !=
                                            null,
                                        listOfStrings: snapshot.data!.movie!
                                            .getSpokenLanguages(),
                                      ),
                                      VisibilityText(
                                        movieAttribute: StringConstants.genres,
                                        isVisible:
                                            snapshot.data!.movie!.genres !=
                                                null,
                                      ),
                                      Center(
                                        child: VisibilityListAttributesName(
                                          movieDetailList:
                                              snapshot.data!.movie!.genres ??
                                                  [],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (snapshot.data!.movie!.belongsToCollection !=
                                    null)
                                  CollectionWidget(
                                    collection: snapshot
                                        .data!.movie!.belongsToCollection!,
                                  ),
                              ],
                            );
                          case Status.error:
                            return errorWidget();
                          case Status.initial:
                            return const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Palette.primaryLight,
                              ),
                            );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
