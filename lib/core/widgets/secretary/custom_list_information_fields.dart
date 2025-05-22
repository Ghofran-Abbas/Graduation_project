import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import 'list_view_information_field.dart';

class CustomListInformationFields extends StatelessWidget {
  const CustomListInformationFields({super.key, required this.secondField, required this.widget, this.showSecondField, this.showFifthField, this.showSecondBox, this.showFirstBox});

  final String? secondField;
  final bool? showSecondField;
  final bool? showFifthField;
  final bool? showFirstBox;
  final bool? showSecondBox;
  final Widget widget;

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
              showSecondBox ?? false ? SizedBox(width: 50.w,) : SizedBox(width: 0.w,),
              Expanded(
                //flex: 2,
                child: Text(
                  AppLocalizations.of(context).translate('Name'),
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 210.w : 145.w,) : SizedBox(width: showSecondBox ?? false ? 225.w : 175.w,),
              showSecondField ?? false ? Expanded(
                //flex: 2,
                child: Text(
                  secondField ?? '',
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ) : SizedBox(width: 0.w, height: 0.h,),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 80.w : 125.w,) : SizedBox(width: showSecondBox ?? false ? 110.w : 150.w,),
              //SizedBox(width: 50.w,),
              Expanded(
                flex: 2,
                child: Text(
                  AppLocalizations.of(context).translate('Email address'),
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 110.w : 192.w,) : SizedBox(width: showSecondBox ?? false ? 182.w : 252.w,),
              //SizedBox(width: 220.w,),
              Expanded(
                //flex: showFifthField ?? false ? 1 : 2,
                //flex: 2,
                child: Text(
                  AppLocalizations.of(context).translate('Gender'),
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 80.w : 120.w,) : SizedBox(width: 0.w, height: 0.h,),
              //SizedBox(width: 220.w,),
              showFifthField ?? false ? Expanded(
                //flex: 3,
                //flex: 1,
                child: Text(
                  AppLocalizations.of(context).translate('Status'),
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ) : SizedBox(width: 0.w, height: 0.h,),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 180.w : 160.w,) : SizedBox(width: showSecondBox ?? false ? 215.w : 255.w,),
            ],
          ),
        ),
        widget,
        /*ListViewInformationField(
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
        ),*/
      ],
    );
  }
}