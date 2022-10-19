import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../../core/util/service_constants.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/movie_event.dart';
import '../bloc/interfaces/i_movies_bloc.dart';
import '../widget/empty_widget.dart';
import '../widget/error_widget.dart';
import '../widget/show_image.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    Provider.of<IMoviesBloc>(
      context,
      listen: false,
    ).getMovies(ServiceConstants.endpoints[StringConstants.nowPlayingTabText]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: Provider.of<IMoviesBloc>(context).getStream(),
        initialData: MovieEvent(status: Status.initial),
        builder: (
          BuildContext context,
          AsyncSnapshot<MovieEvent> snapshot,
        ) {
          switch (snapshot.data!.status) {
            case Status.initial:
            case Status.loading:
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Palette.primaryLight),
              );
            case Status.success:
              return Padding(
                padding: const EdgeInsets.all(Dimensions.nowPlayingGridPadding),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Dimensions.numberOfGridColumns,
                    childAspectRatio: Dimensions.nowPlayingGridAspectRatio,
                    mainAxisSpacing: Dimensions.nowPlayingGridMainAxisSpacing,
                    crossAxisSpacing: Dimensions.nowPlayingGridCrossAxisSpacing,
                  ),
                  itemCount: snapshot.data!.movies!.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.nowPlayingGridContainerBorderRadius,
                        ),
                        color: Palette.containerColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          showImgIfExists(
                            snapshot.data!.movies![index].posterPath,
                            Dimensions.moviePosterSizeNowPlaying,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                Dimensions.nowPlayingTextPadding,
                              ),
                              child: Center(
                                child: AutoSizeText(
                                  snapshot.data!.movies![index].title,
                                  style: const TextStyle(
                                    fontSize:
                                        Dimensions.nowPlayingTitleFontSize,
                                    color: Palette.lightFontColor,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: Dimensions.nowPlayingTextMaxLines,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            case Status.empty:
              return empty();
            case Status.error:
              return errorWidget();
          }
        },
      ),
    );
  }
}
