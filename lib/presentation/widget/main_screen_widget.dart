import 'package:flutter/material.dart';

import '../../core/util/assets_constants.dart';
import '../../core/util/constants.dart';
import '../../core/util/keys.dart';
import '../../core/util/palette.dart';
import '../../core/util/string_constants.dart';
import '../view/search_view.dart';
import '../view/now_playing.dart';
import '../view/top_rated.dart';
import '../view/upcoming.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: Constants.numberOfTabs,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: Constants.logoPadding,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Icon(
                    Icons.circle,
                    color: Palette.details,
                    size: Constants.appbarIconSize,
                  ),
                  Image.asset(
                    AssetsConstants.logo,
                    height: Constants.appbarLogoSize,
                    color: Palette.primary,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: Constants.horizontalPadding,
              child: Text(
                StringConstants.appName,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchView(
                    tabActual: Constants.tabEndpoints[_tabController.index]!,
                  ),
                ),
              )
            },
            icon: const Icon(Icons.search),
          )
        ],
        backgroundColor: Palette.primary,
      ),
      backgroundColor: Palette.background,
      body: Column(
        children: [
          Padding(
            padding: Constants.topSmallPadding,
            child: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                color: Palette.primary,
                borderRadius: Constants.tabIndicatorRadius,
              ),
              indicatorColor: Palette.primary,
              labelColor: Palette.lightFontColor,
              unselectedLabelColor: Palette.primaryLight,
              labelPadding: Constants.topSmallPadding,
              tabs: [
                Tab(
                  child: Column(
                    children: const [
                      Icon(Icons.play_arrow_outlined),
                      Text(StringConstants.nowPlayingTabText),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: const [
                      Icon(Icons.local_fire_department),
                      Text(StringConstants.topRatedTabText),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: const [
                      Icon(Icons.upcoming),
                      Text(StringConstants.upcomingTabText),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Palette.primary),
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  NowPlaying(
                    key: Keys.nowPlayingKey,
                  ),
                  TopRated(
                    key: Keys.topRatedKey,
                  ),
                  Upcoming(
                    key: Keys.upcomingKey,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
