import 'package:flutter/material.dart';

import '../../../core/util/dimensions.dart';
import '../../../core/util/palette.dart';
import '../../../core/util/string_constants.dart';
import '../../../core/util/widget_styles.dart';
import '../show_image.dart';

class VisibilityListOfString extends StatelessWidget {
  const VisibilityListOfString({
    super.key,
    required this.listOfStrings,
    required this.isVisible,
    this.hasBackground = false,
  });

  final List<String> listOfStrings;
  final bool isVisible;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    listOfStrings.forEach(
      (element) {
        children.add(
          Padding(
            padding: const EdgeInsets.all(
              Dimensions.detailScreenContainerVerticalPadding,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  Dimensions.detailScreenListContainersWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.movieDetailContainerBorderRadius,
                ),
                color: hasBackground
                    ? Palette.movieDetailContainerColor
                    : Palette.movieDetailTransparentContainer,
              ),
              child: element.contains(StringConstants.posterPathSeparator)
                  ? Padding(
                      padding: const EdgeInsets.all(
                        Dimensions.detailScreenListVerticalPadding,
                      ),
                      child: Column(
                        children: [
                          showImgIfExists(
                            element.split(StringConstants.posterPathSeparator)[
                                Dimensions
                                    .detailScreenAttributesListImagePosition],
                            Dimensions.productionCompanyLogoHeight,
                            fitType: BoxFit.fitWidth,
                          ),
                          Text(
                            element.split(StringConstants.posterPathSeparator)[
                                Dimensions
                                    .detailScreenAttributesListNamePosition],
                            style: WidgetStyles.detailScreenTextStyle,
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(
                        hasBackground
                            ? Dimensions.detailScreenListVerticalPadding
                            : Dimensions.detailScreenListNoPadding,
                      ),
                      child: Text(
                        element,
                        style: WidgetStyles.detailScreenTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ),
        );
      },
    );
    return Visibility(
      visible: isVisible,
      child: Column(
        children: children,
      ),
    );
  }
}
