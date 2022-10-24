import 'package:flutter/material.dart';

import '../../../core/util/constants.dart';
import '../../../core/util/widget_styles.dart';

class VisibilityText extends StatelessWidget {
  const VisibilityText({
    required this.movieAttribute,
    required this.isVisible,
    super.key,
  });

  final String movieAttribute;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.5,
      ),
      child: Visibility(
        visible: isVisible,
        child: Padding(
          padding: Constants.topSmallPadding,
          child: Text(
            movieAttribute,
            textAlign: TextAlign.center,
            style: WidgetStyles.detailScreenTextStyle,
          ),
        ),
      ),
    );
  }
}
