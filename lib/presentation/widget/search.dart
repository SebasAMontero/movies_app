import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/util/constants.dart';
import '../../core/util/palette.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/movie_event.dart';
import '../bloc/interfaces/i_movies_bloc.dart';
import 'empty_widget.dart';
import 'error_widget.dart';
import 'movie_list.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchWState();
}

class _SearchWState extends State<Search> {
  @override
  void initState() {
    Provider.of<IMoviesBloc>(
      context,
      listen: false,
    ).searchMovies(Constants.emptyString);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Palette.background,
      child: Column(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Palette.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: Constants.searcherHeaderShadowBlur,
                ),
              ],
              borderRadius: Constants.searchHeaderBorderRadius,
            ),
            child: Padding(
              padding: Constants.searchMainContainerPadding,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.inputBoxRadius),
                  border: Border.all(color: Palette.primary),
                ),
                child: TextField(
                  onChanged: (textInputValue) {
                    Provider.of<IMoviesBloc>(
                      context,
                      listen: false,
                    ).searchMovies(
                      textInputValue,
                    );
                  },
                  decoration: const InputDecoration(
                    icon: Padding(
                      padding: Constants.searchInputPadding,
                      child: Icon(
                        Icons.search,
                        color: Palette.primary,
                      ),
                    ),
                    hintText: StringConstants.searchHintText,
                    fillColor: Palette.primary,
                    focusColor: Palette.primary,
                    iconColor: Palette.primary,
                    helperStyle: TextStyle(color: Palette.primary),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.primary,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: Constants.mainSearchContainerPadding,
              decoration: const BoxDecoration(
                borderRadius: Constants.searchContainerRadius,
                color: Palette.primary,
              ),
              child: Center(
                child: StreamBuilder<MovieEvent>(
                  stream: Provider.of<IMoviesBloc>(context).getStream(),
                  initialData: MovieEvent(
                    status: Status.loading,
                  ),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<MovieEvent> snapshot,
                  ) {
                    switch (snapshot.data!.status) {
                      case Status.initial:
                        return const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Palette.primaryLight,
                          ),
                        );
                      case Status.loading:
                        return const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Palette.primaryLight,
                          ),
                        );
                      case Status.success:
                        return Padding(
                          padding: Constants.topSmallPadding,
                          child: buildMovieList(snapshot.data!.movies!),
                        );
                      case Status.empty:
                        return empty();
                      case Status.error:
                        return errorWidget();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
