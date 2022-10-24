import 'package:flutter/material.dart';

import 'dimensions.dart';

abstract class WidgetStyles {
  static const TextStyle detailScreenTextStyle = TextStyle(
    fontSize: Dimensions.visibilityTextFontSize,
    color: Colors.white,
  );

  static const TextStyle visibilityListTextStyle = TextStyle(
    fontSize: Dimensions.visibilityListFontSize,
    color: Colors.white,
  );
  static const TextStyle collectionTextStyle = TextStyle(
    color: Colors.white70,
    fontSize: 25,
    letterSpacing: 8,
  );
}
