import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import 'list_view_information_field.dart';

class CustomListInformationFields extends StatelessWidget {
  const CustomListInformationFields({super.key, required this.secondField, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.widthProfileText, required this.name, this.nameColor, this.showDetailsText, this.secondText, this.secondTextColor, this.showSecondDetailsText, this.thirdDetailsText, this.thirdDetailsTextColor, this.fourthDetailsText, this.fourthDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, required this.itemCount});

  final String secondField;
  final double? width;
  final double? height;
  final Color? color;
  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageBorderRadius;
  final double? widthProfileText;
  final String name;
  final Color? nameColor;
  final bool? showDetailsText;
  final String? secondText;
  final Color? secondTextColor;
  final bool? showSecondDetailsText;
  final String? thirdDetailsText;
  final Color? thirdDetailsTextColor;
  final String? fourthDetailsText;
  final Color? fourthDetailsTextColor;
  final bool? showIcons;
  final double? heightTextIcon;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Function onTap;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1151.24.w,
          height: 48.72.h,
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Name',
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 80.w,),
              Expanded(
                flex: 1,
                child: Text(
                  secondField,
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 50.w,),
              Expanded(
                flex: 1,
                child: Text(
                  'Email address',
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 220.w,),
              Expanded(
                flex: 2,
                child: Text(
                  'Gender',
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        ListViewInformationField(
          image: image,
          name: name,
          secondText: secondText,
          thirdDetailsText: thirdDetailsText,
          fourthDetailsText: fourthDetailsText,
          itemCount: itemCount,
          showIcons: showIcons,
          onTap: (){onTap();},
          width: width,
          height: height,
          imageWidth: imageWidth,
          imageHeight: imageHeight,
          imageBorderRadius: imageBorderRadius,
          widthProfileText: widthProfileText,
          nameColor: nameColor,
          showDetailsText: showDetailsText,
          secondTextColor: secondTextColor,
          showSecondDetailsText: showSecondDetailsText,
          thirdDetailsTextColor: thirdDetailsTextColor,
          fourthDetailsTextColor: fourthDetailsTextColor,
          heightTextIcon: heightTextIcon,
          leftIcon: leftIcon,
          rightIcon: rightIcon,
        ),
      ],
    );
  }
}