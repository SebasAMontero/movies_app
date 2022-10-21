import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/util/constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../../core/util/service_constants.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/movie_event.dart';
import '../bloc/interfaces/i_movies_bloc.dart';
import '../widget/empty_widget.dart';
import '../widget/error_widget.dart';
import '../widget/show_image.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  void initState() {
    Provider.of<IMoviesBloc>(
      context,
      listen: false,
    ).getMovies(ServiceConstants.endpoints[StringConstants.upcomingText]);
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
              return CarouselSlider.builder(
                itemCount: snapshot.data!.movies!.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                  int pageViewIndex,
                ) {
                  return Column(
                    children: [
                      showImgIfExists(
                        snapshot.data!.movies![index].posterPath,
                        Dimensions.moviePosterSize,
                      ),
                      Text(
                        snapshot.data!.movies![index].title,
                        style: const TextStyle(
                          fontSize: Dimensions.upcomingTitleFontSize,
                          color: Palette.lightFontColor,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                },
                options: CarouselOptions(
                  viewportFraction: Dimensions.carouselViewportFraction,
                  enableInfiniteScroll: Constants.carouselInfiniteScroll,
                  autoPlay: Constants.carouselAutoPlay,
                  enlargeCenterPage: Constants.carouselEnlargeCenterPage,
                  scrollDirection: Axis.vertical,
                  height: MediaQuery.of(context).size.height,
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
