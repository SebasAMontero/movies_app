import 'package:flutter/material.dart';
import '../../../core/util/widget_styles.dart';

class VisibilityListAttributesName extends StatelessWidget {
  const VisibilityListAttributesName({
    required this.movieDetailList,
    super.key,
  });

  final List<dynamic> movieDetailList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: movieDetailList.length,
          itemBuilder: (
            BuildContext context,
            index,
          ) {
            return Text(
              textAlign: TextAlign.center,
              style: WidgetStyles.visibilityListTextStyle,
              '${movieDetailList[index].name}',
            );
          },
        ),
      ],
    );
  }
}
