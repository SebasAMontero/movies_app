import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/util/assets_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../../core/util/service_constants.dart';

Widget showImgIfExists(String img, double height) {
  return CachedNetworkImage(
    imageUrl: '${ServiceConstants.imagePath}$img',
    imageBuilder: (BuildContext context, ImageProvider img) {
      return Container(
        height: height,
        width: MediaQuery.of(context).size.width*0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: img,
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
        Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
        valueColor: const AlwaysStoppedAnimation<Color>(Palette.primaryLight),
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
