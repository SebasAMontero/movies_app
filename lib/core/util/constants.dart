import 'package:flutter/material.dart';

abstract class Constants {
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
  static const BorderRadius searchContainerRadius =
      BorderRadius.vertical(top: Radius.circular(10));
  static const double connectionStatusIconSize = 10;
  static const EdgeInsets topSmallPadding = EdgeInsets.only(top: 10);

  static const int numberOfTabs = 3;
  static const double notFoundIconSize = 50;
  static const double notFoundFontSize = 20;
  static const String emptyString = '';
  static const double searcherAppBarElevation = 0;
  static const double searcherHeaderShadowBlur = 5;
  static const BorderRadius searchHeaderBorderRadius = BorderRadius.vertical(
    bottom: Radius.circular(10),
  );
  static const EdgeInsets searchMainContainerPadding = EdgeInsets.all(20);
  static const double inputBoxRadius = 10;
  static const EdgeInsets mainSearchContainerPadding = EdgeInsets.only(top: 15);
  static const EdgeInsets searchInputPadding =
      EdgeInsets.symmetric(horizontal: 10.0);
  static const bool carouselAutoPlay = true;
  static const bool carouselInfiniteScroll = false;
  static const bool carouselEnlargeCenterPage = true;
  static const Map<int, String> tabEndpoints = {
    0: '/movie/now_playing',
    1: '/movie/top_rated',
    2: '/movie/upcoming',
  };
  static const double collectionOpacityStart = 0.8;
  static const double collectionOpacityEnd = 0.2;
}
