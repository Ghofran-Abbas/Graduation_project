import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_network/image_network.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({
    super.key,
    this.imageHeight,
    this.imageWidth,
    this.borderRadius,
    this.image,
  });
  final double? imageHeight;
  final double? imageWidth;
  final double? borderRadius;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return ImageNetwork(
      image: "http://127.0.0.1:8080/${image!}",
      // put a height and width because they are required
      height: imageHeight ?? 55,
      width: imageWidth ?? 50,
      borderRadius: BorderRadius.circular(borderRadius ?? 35.0),
      curve: Curves.easeIn,
      fitWeb: BoxFitWeb.cover,
      onLoading: const CircularProgressIndicator(
        color: Colors.indigoAccent,
      ),
      onError: const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}

class CustomImageAsset extends StatelessWidget {
  const CustomImageAsset({
    super.key,
    this.imageHeight,
    this.imageWidth,
    this.borderRadius,
    this.image, this.color,
  });
  final double? imageHeight;
  final double? imageWidth;
  final double? borderRadius;
  final String? image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight ?? 55,
      width: imageWidth ?? 50,
      decoration: BoxDecoration(
        color: color ?? AppColors.lightPurple,
        borderRadius: BorderRadius.circular(borderRadius ?? 35.0),
        /*image: const DecorationImage(
          image: AssetImage(Assets.logo),
        )*/
      ),
    );
  }
}

class CustomMemoryImage extends StatelessWidget {
  const CustomMemoryImage({super.key, this.imageHeight, this.imageWidth, this.borderRadius, this.image, this.color});

  final double? imageHeight;
  final double? imageWidth;
  final double? borderRadius;
  final Uint8List? image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight ?? 55.w,
      width: imageWidth ?? 50.w,
      decoration: BoxDecoration(
        color: color ?? AppColors.lightPurple,
        borderRadius: BorderRadius.circular(borderRadius ?? 35.0),
        image: DecorationImage(
          image: MemoryImage(image!,),
          fit: BoxFit.fill
        )
      ),
    );
  }
}

