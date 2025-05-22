import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import 'grid_view_cards.dart';

class CustomOverLoadingCard extends StatelessWidget {
  const CustomOverLoadingCard({super.key,required this.cardCount, required this.onTapSeeMore, required this.widget});

  final int cardCount;
  final Function onTapSeeMore;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
            children: [
              SizedBox(
                width: 1049.2.w,
                child: widget,
                /*child: GridViewCards(
                  cardCount: calculateCardCount(cardCount: cardCount),
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
                  onTap: (){
                    onTapCard();
                  },
                ),*/
              ),
              Positioned(
                left: 870.w,
                top: 170.h,
                child: GestureDetector(
                  onTap: (){
                    onTapSeeMore();
                  },
                  child: Text(
                    /*seeMoreText ?? */cardCount > 4 ? AppLocalizations.of(context).translate('See more') : '',
                    style: Styles.l3Normal(color: AppColors.purple),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ]
        ),
      ],
    );
  }
}

int calculateCardCount({required int cardCount,}) {
  if(cardCount > 4) {
    cardCount = 4;
  } else if(cardCount == 4) {
    cardCount = 4;
  } else if(cardCount == 3) {
    cardCount = 3;
  } else if(cardCount == 2) {
    cardCount = 2;
  } else if(cardCount == 1) {
    cardCount = 1;
  } else {
    cardCount = 0;
  }
  return cardCount;
}
/*
double calculateSeeMorePosition({required int cardCount,}) {
  double position;
  if(cardCount > 4) {
    position = 870.w;
  } else if(cardCount == 4) {
    position = 870.w;
  } else if(cardCount == 3) {
    position = 650.w;
  } else if(cardCount == 2) {
    position = 430.w;
  } else if(cardCount == 1) {
    position = 210.w;
  } else {
    position = 870.w;
  }
  return position;
}*/