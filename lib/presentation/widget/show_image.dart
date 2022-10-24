import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/util/assets_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../../core/util/service_constants.dart';

Widget showImgIfExists(
  String img,
  double height, {
  fitType = BoxFit.fill,
  softBorder = true,
  fullWidth = false,
}) {
  return CachedNetworkImage(
    imageUrl: '${ServiceConstants.imagePath}$img',
    imageBuilder: (
      BuildContext context,
      ImageProvider img,
    ) {
      return Container(
        height: height,
        width: fullWidth
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: fitType,
            image: img,
          ),
          borderRadius: BorderRadius.circular(
            softBorder
                ? Dimensions.posterImageBorderRadius
                : Dimensions.noRadius,
          ),
          shape: BoxShape.rectangle,
        ),
      );
    },
    progressIndicatorBuilder: (
      context,
      url,
      downloadProgress,
    ) =>
        SizedBox(
      height: Dimensions.loaderBoxHeight,
      width: Dimensions.loaderBoxWidth,
      child: Center(
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          valueColor: const AlwaysStoppedAnimation<Color>(Palette.primaryLight),
        ),
      ),
    ),
    errorWidget: (
      context,
      url,
      error,
    ) =>
        Image.asset(
      AssetsConstants.pathToNoRecordingImg,
      height: Dimensions.assetImageDimension,
      width: Dimensions.assetImageDimension,
    ),
  );
}
