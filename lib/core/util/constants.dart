import 'package:flutter/material.dart';

abstract class Constants {
  static const String appName = 'Movies DB';
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(
    vertical: 0,
    horizontal: 5,
  );
  static const double appbarIconSize = 45.0;
  static const double appbarLogoSize = 25.0;
  static const EdgeInsets sectionSeparatorPadding = EdgeInsets.all(15);
  static const EdgeInsets logoPadding = EdgeInsets.symmetric(horizontal: 5.0);
  static const BorderRadius tabIndicatorRadius =
      BorderRadius.vertical(top: Radius.circular(20));
  static const double connectionStatusIconSize = 10;
  static const String onlineTextDisplay = 'online';
  static const String offlineTextDisplay = 'offline';
  static const EdgeInsets topSmallPadding = EdgeInsets.only(top: 10);
  static const String nowPlayingTabText = 'Now Playing';
  static const String upcomingTabText = 'Upcoming';
  static const String topRatedTabText = 'Top rated';
  static const int numberOfTabs = 3;
  static const double notFoundIconSize = 50;
  static const String notFoundMessage = 'Nothing found';
  static const double notFoundFontSize = 20;
  static const String logo = 'assets/images/clapperboard.webp';
  static const bool carouselAutoPlay = true;
  static const bool carouselInfiniteScroll = false;
  static const bool carouselEnlargeCenterPage = true;
}
