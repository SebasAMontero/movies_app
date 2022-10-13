import 'package:flutter/material.dart';

import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../../core/util/string_constants.dart';

Widget empty() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(
        Icons.do_not_disturb_off_outlined,
        size: Dimensions.emptyIconSize,
        color: Palette.primaryLight,
      ),
      Padding(
        padding: EdgeInsets.only(top: Dimensions.iconPadding),
        child: Text(
          StringConstants.notFoundMessage,
          style: TextStyle(
            color: Palette.primaryLight,
            fontSize: Dimensions.emptyFontSize,
          ),
        ),
      ),
    ],
  );
}
