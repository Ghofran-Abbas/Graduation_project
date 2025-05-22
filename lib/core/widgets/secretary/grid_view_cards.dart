import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_icon_button.dart';
import '../custom_image_network.dart';

/*class GridViewCards extends StatelessWidget {
  const GridViewCards({super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.heightProfileText, required this.text, this.textColor, this.showDetailsText, this.detailsText, this.detailsTextColor, this.showSecondDetailsText, this.secondDetailsText, this.secondDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, required this.cardCount});

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
  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
      itemBuilder: (BuildContext context, int index) {
        return Align(child: CustomCard(
          width: width,
          height: height,
          color: color,
          image: image,
          imageWidth: imageWidth,
          imageHeight: imageHeight,
          imageBorderRadius: imageBorderRadius,
          heightProfileText: heightProfileText,
          text: text,
          textColor: textColor,
          showDetailsText: showDetailsText,
          detailsText: detailsText,
          detailsTextColor: detailsTextColor,
          showSecondDetailsText: showSecondDetailsText,
          secondDetailsText: secondDetailsText,
          secondDetailsTextColor: secondDetailsTextColor,
          showIcons: showIcons,
          heightTextIcon: heightProfileText,
          leftIcon: leftIcon,
          rightIcon: rightIcon,
          onTap: (){onTap();},
        ));
      },
      itemCount: cardCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}*/

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.heightProfileText, required this.text, this.textColor, this.showDetailsText, this.detailsText, this.detailsTextColor, this.showSecondDetailsText, this.secondDetailsText, this.secondDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, this.showRating, this.ratingIcon, this.ratingIconColor, this.ratingIconSize, this.ratingText, this.ratingTextColor, this.showCheckEndCourse, required this.onTapFirstIcon, required this.onTapSecondIcon,
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