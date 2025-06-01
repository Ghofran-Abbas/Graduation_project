import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_image_network.dart';

class CustomOverloadingAvatar extends StatelessWidget {
  const CustomOverloadingAvatar({super.key, required this.labelText, this.firstImage, this.secondImage, this.thirdImage, this.fourthImage, this.fifthImage, required this.tailText, required this.avatarCount, required this.onTap});

  final String labelText;
  final String? firstImage;
  final String? secondImage;
  final String? thirdImage;
  final String? fourthImage;
  final String? fifthImage;
  final String tailText;
  final int avatarCount;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    double width = calculateWidthAvatar(avatarCount: avatarCount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Styles.l2Bold(color: AppColors.t4),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 38.h,),
        GestureDetector(
          onTap: (){onTap();},
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  avatarCount >= 1 ? firstImage != null ? CustomImageNetwork(
                    imageWidth: 48.w,
                    imageHeight: 44.w,
                    borderRadius: 50.67.r,
                    image: firstImage,
                  ) : CustomImageAsset(
                    imageWidth: 48.w,
                    imageHeight: 44.w,
                    borderRadius: 50.67.r,
                  ) : SizedBox(width: 0.0.w, height: 0.0.h,),
                  avatarCount >= 2 ? secondImage != null ? Positioned(
                    left: 30.1.w,
                    child: CustomImageNetwork(
                      imageWidth: 48.w,
                      imageHeight: 44.w,
                      borderRadius: 50.67.r,
                      image: secondImage,
                    )
                  ) : CustomImageAsset(
                    imageWidth: 48.w,
                    imageHeight: 44.w,
                    borderRadius: 50.67.r,
                  ) : SizedBox(width: 0.0.w, height: 0.0.h,),
                  avatarCount >= 3 ? thirdImage != null ? Positioned(
                    left: 60.3.w,
                    child: CustomImageNetwork(
                      imageWidth: 48.w,
                      imageHeight: 44.w,
                      borderRadius: 50.67.r,
                      image: thirdImage,
                    )
                  ) : CustomImageAsset(
                    imageWidth: 48.w,
                    imageHeight: 44.w,
                    borderRadius: 50.67.r,
                  ) : SizedBox(width: 0.0.w, height: 0.0.h,),
                  avatarCount >= 4 ? fourthImage != null ? Positioned(
                    left: 90.5.w,
                    child: CustomImageNetwork(
                      imageWidth: 48.w,
                      imageHeight: 44.w,
                      borderRadius: 50.67.r,
                      image: fourthImage,
                    )
                  ) : CustomImageAsset(
                    imageWidth: 48.w,
                    imageHeight: 44.w,
                    borderRadius: 50.67.r,
                  ) : SizedBox(width: 0.0.w, height: 0.0.h,),
                  avatarCount >= 5 ? fifthImage != null ? Positioned(
                    left: 120.7.w,
                    child: CustomImageNetwork(
                      imageWidth: 48.w,
                      imageHeight: 44.w,
                      borderRadius: 50.67.r,
                      image: fifthImage,
                    )
                  ) : CustomImageAsset(
                    imageWidth: 48.w,
                    imageHeight: 44.w,
                    borderRadius: 50.67.r,
                  ) : SizedBox(width: 0.0.w, height: 0.0.h,),
                  /*Align(
                    widthFactor: width,
                    heightFactor: 4.3.h,
                    child: Text(
                      tailText,
                      style: Styles.l3Normal(color: AppColors.purple),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),*/
                ],
              ),
              SizedBox(width: width,),
              Text(
                tailText,
                style: Styles.l3Normal(color: AppColors.purple),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

int calculateAvatarCount({required int avatarCount,}) {
  if(avatarCount > 4) {
    avatarCount = 4;
  } else if(avatarCount == 4) {
    avatarCount = 4;
  } else if(avatarCount == 3) {
    avatarCount = 3;
  } else if(avatarCount == 2) {
    avatarCount = 2;
  } else if(avatarCount == 1) {
    avatarCount = 1;
  } else {
    avatarCount = 0;
  }
  return avatarCount;
}

double calculateWidthAvatar({
  required int avatarCount
})
{
  double width = 8.6;
  if(avatarCount >= 1) {
    width = 6.w;
  }
  if(avatarCount >= 2) {
    width = 45.w;
  }
  if(avatarCount >= 3) {
    width = 78.w;
  }
  if(avatarCount >= 4) {
    width = 105.w;
  }
  if(avatarCount >= 5) {
    width = 138.w;
  }
  return width;
}