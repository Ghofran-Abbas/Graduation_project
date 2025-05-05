import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';

class CustomProfileCards extends StatelessWidget {
  const CustomProfileCards({super.key, required this.labelText, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.heightProfileText, required this.text, this.textColor, this.showDetailsText, this.detailsText, this.detailsTextColor, this.showSecondDetailsText, this.secondDetailsText, this.secondDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.cardCount, required this.onTapCard, this.seeMoreText, required this.onTapSeeMore});

  final String labelText;
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
  final int cardCount;
  final Function onTapCard;
  final String? seeMoreText;
  final Function onTapSeeMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 52.h, bottom: 20.h, left: 20.w, right: 20.w,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: Styles.b2Bold(color: AppColors.t4),
          ),
          SizedBox(height: 10.h,),
          CustomOverLoadingCard(
            cardCount: cardCount,
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
            onTapCard: (){
              onTapCard();
            },
            onTapSeeMore: (){
              onTapSeeMore();
            },
          ),
        ],
      ),
    );
  }
}