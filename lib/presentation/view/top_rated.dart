import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/util/palette.dart';
import '../../core/util/service_constants.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/movie_event.dart';
import '../bloc/interfaces/i_movies_bloc.dart';
import '../widget/empty_widget.dart';
import '../widget/error_widget.dart';
import '../widget/movie_list.dart';

class TopRated extends StatefulWidget {
  const TopRated({Key? key}) : super(key: key);

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  @override
  void initState() {
    Provider.of<IMoviesBloc>(
      context,
      listen: false,
    ).getMovies(ServiceConstants.endpoints[StringConstants.topRatedKey]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<MovieEvent>(
        stream: Provider.of<IMoviesBloc>(context).getStream(),
        initialData: MovieEvent(status: Status.loading),
        builder: (
          BuildContext context,
          AsyncSnapshot<MovieEvent> snapshot,
        ) {
          switch (snapshot.data!.status) {
            case Status.initial:
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Palette.primaryLight),
              );
            case Status.loading:
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Palette.primaryLight),
              );
            case Status.success:
              return buildMovieList(snapshot.data!.movies!);
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
