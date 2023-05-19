import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/assets.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: PlaceHolder(
          fit: fit,
          width: width,
          height: height,
        ),
      );
    }
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return const Center(child: Text('Image'));
    }
    final memCacheHeight = height == null ? null : (height! * 2).toInt();
    final memCacheWidth = width == null ? null : (width! * 2).toInt();
    CachedNetworkImage.logLevel = CacheManagerLogLevel.none;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        fit: fit,
        width: width,
        height: height,
        memCacheHeight: memCacheHeight,
        memCacheWidth: memCacheWidth,
        imageUrl: imageUrl!,

        // CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: SizedBox(
              width: (width ?? 40) / 2,
              height: (height ?? 40) / 2,
              child: Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            ),
          );
        },
        // progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        //   width: 50,
        //   height: 50,
        //   child: const Padding(
        //     padding: EdgeInsets.all(18.0),
        //     child: CircularProgressIndicator(),
        //   ),
        // ),

        errorWidget: (context, url, error) => PlaceHolder(
          fit: fit,
          width: width,
          height: height,
        ),
      ),
    );
  }
}

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({
    Key? key,
    this.asset,
    this.fit,
    this.width,
    this.height,
  }) : super(key: key);
  final String? asset;
  final BoxFit? fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.placeHolder,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
