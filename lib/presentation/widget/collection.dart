import 'package:flutter/material.dart';

import '../../core/util/constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/widget_styles.dart';
import '../../data/model/collection_model.dart';
import 'show_image.dart';

class CollectionWidget extends StatelessWidget {
  const CollectionWidget({
    required this.collection,
    super.key,
  });

  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.topSmallPadding,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          showImgIfExists(
            collection.backdropPath!,
            Dimensions.collectionHeight,
            softBorder: false,
            fitType: BoxFit.cover,
            fullWidth: true,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: Dimensions.collectionHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black54.withOpacity(Constants.collectionOpacityStart),
                  Colors.black54.withOpacity(Constants.collectionOpacityEnd),
                ],
              ),
            ),
            child: Text(
              collection.name!,
              style: WidgetStyles.collectionTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
