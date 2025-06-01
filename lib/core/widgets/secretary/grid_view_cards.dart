import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_icon_button.dart';
import '../custom_image_network.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.heightProfileText, required this.text, this.textColor, this.showDetailsText, this.detailsText, this.detailsTextColor, this.showSecondDetailsText, this.secondDetailsText, this.secondDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, this.showRating, this.ratingIcon, this.ratingIconColor, this.ratingIconSize, this.ratingText, this.ratingTextColor, this.showCheckEndCourse, required this.onTapFirstIcon, required this.onTapSecondIcon, this.dateText, this.showDate,
  });

  final double? width;
  final double? height;
  final Color? color;
  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageBorderRadius;
  final double? heightProfileText;
  final String text;
  final Color? textColor;
  final bool? showDetailsText;
  final String? detailsText;
  final Color? detailsTextColor;
  final bool? showSecondDetailsText;
  final String? secondDetailsText;
  final Color? secondDetailsTextColor;
  final bool? showIcons;
  final double? heightTextIcon;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Function onTap;
  final bool? showRating;
  final IconData? ratingIcon;
  final Color? ratingIconColor;
  final double? ratingIconSize;
  final String? ratingText;
  final Color? ratingTextColor;
  final bool? showCheckEndCourse;
  final String? dateText;
  final bool? showDate;
  final Function onTapFirstIcon;
  final Function onTapSecondIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Card(
        elevation: 4.r,
        shadowColor: Colors.black,
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.5.r), side: BorderSide.none),
        child: Container(
          padding: EdgeInsets.only(top: 20.0.h, bottom: 0.0.h, left: 20.0.w, right: 20.0.w),
          width: width ?? 208.21.w,
          height: height ?? 327.66.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13.5)),
            color: color ?? AppColors.white,
          ),
          child: Column(
            mainAxisAlignment: (showDetailsText ?? false) && (showIcons ?? false) ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              //image
              Stack(
                children: [
                  image != null ? CustomImageNetwork(
                    image: image,
                    imageWidth: /*(showDetailsText ?? false) && (showIcons ?? false) ? 81.02.w : */imageWidth ?? 104.w,
                    imageHeight: /*(showDetailsText ?? false) && (showIcons ?? false) ? 81.02.w : */imageHeight ?? 104.w,
                    borderRadius: imageBorderRadius ?? 80.r,
                  )
                      : CustomImageAsset(
                    imageWidth: /*(showDetailsText ?? false) && (showIcons ?? false) ? 81.02.w : */imageWidth ?? 104.w,
                    imageHeight: /*(showDetailsText ?? false) && (showIcons ?? false) ? 81.02.w : */imageHeight ?? 104.w,
                    borderRadius: imageBorderRadius ?? 80.r,
                  ),
                  showCheckEndCourse ?? false ?Positioned(
                    top: 75.w,
                    left: 75.w,
                    child: CustomIconButton(
                      icon: Icons.check,
                      backgroundColor: AppColors.mintGreen,
                      onTap: () {},
                    ),
                  ) : SizedBox(width: 0, height: 0,),
                ],
              ),
              //Title
              SizedBox(height: heightProfileText ?? 16.h,),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: Styles.b2Bold(color: textColor ?? AppColors.blue),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              //Details text
              SizedBox(height: showDetailsText ?? false ? 6.08.h : 0.0,),
              showDetailsText ?? false ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      detailsText ?? '',
                      style: Styles.l1Normal(color: textColor ?? AppColors.t1),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 46.w,),
                  Expanded(
                    child: Text(
                      secondDetailsText ?? '',
                      style: Styles.l1Normal(color: textColor ?? AppColors.t1),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ) : SizedBox(width: 0, height: 0,),
              SizedBox(height: showDate ?? false ? 20.08.h : 0.0,),
              showDate ?? false ? Expanded(
                child: Text(
                  dateText ?? '',
                  style: Styles.b2Normal(color: textColor ?? AppColors.t1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ) : SizedBox(width: 0, height: 0,),
              //Action icons
              SizedBox(height: showDetailsText ?? false ? 15.08.h : 20.0.h,),
              showIcons ?? false ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(icon: leftIcon ?? Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                  SizedBox(width: 10.8.w,),
                  CustomIconButton(icon: rightIcon ?? Icons.delete_outline, onTap: (){onTapSecondIcon();},),
                ],
              ) : SizedBox(width: 0, height: 0,),
              showRating ?? false ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ratingText ?? '',
                    style: Styles.b2Bold(color: ratingTextColor ?? AppColors.blue),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 8.w,),
                  Icon(
                    ratingIcon ?? Icons.star,
                    color: ratingIconColor ?? AppColors.gold,
                    size: ratingIconSize ?? 32.r,
                  ),
                ],
              ) : SizedBox(width: 0, height: 0,),
            ],
          ),
        ),
      ),
    );
  }
}