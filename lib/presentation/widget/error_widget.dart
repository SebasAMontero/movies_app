import 'package:flutter/material.dart';

import '../../core/util/assets_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../../core/util/string_constants.dart';


Widget errorWidget() {
  return Center(
    child: Column(
      children: [
        Image.asset(AssetsConstants.pathToNoRecordingImg),
        const Text(
          StringConstants.errorMessage,
          style: TextStyle(
            color: Palette.lightFontColor,
            fontSize: Dimensions.errorFontSize,
          ),
        ),
      ],
    ),
  );
}
