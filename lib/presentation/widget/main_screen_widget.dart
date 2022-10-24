import 'package:flutter/material.dart';

import '../../core/util/constants.dart';
import '../../core/util/keys.dart';
import '../../core/util/palette.dart';
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
                    Constants.logo,
                    height: Constants.appbarLogoSize,
                    color: Palette.primary,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: Constants.horizontalPadding,
              child: Text(
                Constants.appName,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => {},
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
                      Text(Constants.nowPlayingTabText),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: const [
                      Icon(Icons.local_fire_department),
                      Text(Constants.topRatedTabText),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: const [
                      Icon(Icons.upcoming),
                      Text(Constants.upcomingTabText),
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
          ),
        ],
      ),
    );
  }
}
