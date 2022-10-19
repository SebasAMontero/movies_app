import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/util/constants.dart';
import '../../core/util/palette.dart';
import '../../core/util/string_constants.dart';
import '../bloc/interfaces/i_movies_bloc.dart';
import '../widget/search.dart';

class SearchView extends StatelessWidget {
  final String tabActual;

  const SearchView({Key? key, required this.tabActual}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Constants.searcherAppBarElevation,
        backgroundColor: Palette.primary,
        title: const Text(StringConstants.searchViewTitle),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                Provider.of<IMoviesBloc>(
                  context,
                  listen: false,
                ).getMovies(tabActual);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: const Search(),
    );
  }
}
