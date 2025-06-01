import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_icon_button.dart';
import '../custom_image_network.dart';
import 'custom_about.dart';

class CustomCourseInformation extends StatelessWidget {
  const CustomCourseInformation({super.key, this.image, this.imageWidth, this.imageHeight, this.borderRadius, this.infoTopPadding, this.ratingIcon, this.ratingIconColor, this.ratingIconSize, this.ratingText, this.ratingTextColor, this.ratingPercent, this.ratingPercentText, this.ratingPercentTextColor, this.circleStatusSize, this.circleStatusColor, this.courseStatusText, this.showEditStatusIcon, this.startDateIcon, this.startDateIconColor, this.startDateIconSize, this.startDateText, this.showCourseCalenderIcon, this.courseCalenderIcon, this.courseCalenderIconColor, this.courseCalenderIconSize, this.endDateIcon, this.endDateIconColor, this.endDateIconSize, this.endDateText, this.numberSeatsIcon, this.numberSeatsIconColor, this.numberSeatsIconSize, this.numberSeatsText, this.labelText, required this.bodyText, this.bigText, required this.onTap, required this.onTapDate, this.showSectionInformation, this.showIcons, this.hideFirstIcon, required this.onTapFirstIcon, required this.onTapSecondIcon,});

  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final double? borderRadius;

  final double? infoTopPadding;
  final IconData? ratingIcon;
  final Color? ratingIconColor;
  final double? ratingIconSize;
  final String? ratingText;
  final Color? ratingTextColor;
  final double? ratingPercent;
  final String? ratingPercentText;
  final Color? ratingPercentTextColor;
  final double? circleStatusSize;
  final Color? circleStatusColor;
  final String? courseStatusText;
  final bool? showEditStatusIcon;
  final IconData? startDateIcon;
  final Color? startDateIconColor;
  final double? startDateIconSize;
  final String? startDateText;
  final bool? showCourseCalenderIcon;
  final IconData? courseCalenderIcon;
  final Color? courseCalenderIconColor;
  final double? courseCalenderIconSize;
  final IconData? endDateIcon;
  final Color? endDateIconColor;
  final double? endDateIconSize;
  final String? endDateText;
  final IconData? numberSeatsIcon;
  final Color? numberSeatsIconColor;
  final double? numberSeatsIconSize;
  final String? numberSeatsText;
  final String? labelText;
  final String bodyText;
  final bool? bigText;
  final Function onTap;
  final Function onTapDate;
  final bool? showSectionInformation;
  final bool? showIcons;
  final bool? hideFirstIcon;
  final Function onTapFirstIcon;
  final Function onTapSecondIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            image != null ? CustomImageNetwork(
              image: image,
              imageWidth: imageWidth ?? 176.w,
              imageHeight: imageHeight ?? 176.w,
              borderRadius: borderRadius ?? 150.67.r,
            )
                : CustomImageAsset(
              imageWidth: imageWidth ?? 176.w,
              imageHeight: imageHeight ?? 176.w,
              borderRadius: borderRadius ?? 150.67.r,
            ),
            SizedBox(height: 30.0.h,),
            showIcons ?? false ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hideFirstIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                SizedBox(width: 10.8.w,),
                CustomIconButton(icon: Icons.delete_outline, onTap: (){onTapSecondIcon();},),
              ],
            ) : SizedBox(width: 0, height: 0,),
          ],
        ),
        SizedBox(width: 24.w,),
        showSectionInformation ?? false ? Padding(
          padding: EdgeInsets.only(top: infoTopPadding ?? 28.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    ratingIcon ?? Icons.star,
                    color: ratingIconColor ?? AppColors.gold,
                    size: ratingIconSize ?? 52.r,
                  ),
                  SizedBox(width: 8.w,),
                  Text(
                    ratingText ?? '',
                    style: Styles.h3Bold(color: ratingTextColor ?? AppColors.blue),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 38.w,),
                  CircularPercentIndicator(
                    radius: 40.0.r,
                    lineWidth: 5.0,
                    percent: ratingPercent ?? 1,
                    center: Text(
                      ratingPercentText ?? '',
                      style: Styles.l1Bold(color: ratingPercentTextColor ?? AppColors.blue),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    progressColor: AppColors.purple,
                    backgroundColor: AppColors.lightPurple,
                    circularStrokeCap: CircularStrokeCap.butt,
                    reverse: true,
                    animation: true,
                  ),
                ],
              ),
              SizedBox(height: 29.h,),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      maxRadius: circleStatusSize ?? 10.r,
                      backgroundColor: circleStatusColor ?? AppColors.mintGreen,
                    ),
                    SizedBox(width: 17.w,),
                    Text(
                      courseStatusText ?? '',
                      style: Styles.b2Bold(color: AppColors.t1),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 17.w,),
                    showEditStatusIcon ?? false ? CustomIconButton(icon: Icons.edit_outlined, onTap: (){onTap();},) : SizedBox(width: 0.0.w, height: 0.0.h,),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Row(
                children: [
                  Icon(
                    startDateIcon ?? Icons.rocket_launch_outlined,
                    color: startDateIconColor ?? AppColors.purple,
                    size: startDateIconSize ?? 35.r,
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    startDateText ?? '',
                    style: Styles.b2Bold(color: AppColors.t1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 23.w,),
                  showCourseCalenderIcon ?? false ? CustomIconButton(
                    icon: courseCalenderIcon ?? Icons.calendar_today_outlined,
                    color: courseCalenderIconColor ?? AppColors.purple,
                    backgroundColor: AppColors.white,
                    size: courseCalenderIconSize ?? 35.r,
                    onTap: (){onTapDate();},
                  ) : SizedBox(width: 0.0.w, height: 0.0.h,),
                ],
              ),
              SizedBox(height: 13.h,),
              Row(
                children: [
                  Icon(
                    endDateIcon ?? Icons.rocket_launch_outlined,
                    color: endDateIconColor ?? AppColors.purple,
                    size: endDateIconSize ?? 35.r,
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    endDateText ?? '',
                    style: Styles.b2Bold(color: AppColors.t1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: 11.h,),
              Row(
                children: [
                  Icon(
                    numberSeatsIcon ?? Icons.group_outlined,
                    color: numberSeatsIconColor ?? AppColors.purple,
                    size: numberSeatsIconSize ?? 35.r,
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    numberSeatsText ?? '',
                    style: Styles.b2Bold(color: AppColors.t1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ) : SizedBox(width: 200.w, height: 0.h,),
        SizedBox(width: 250.w,),
        Expanded(
          child: SizedBox(
            width: 324.w,
            child: CustomAbout(labelText: labelText, bodyText: bodyText, bigText: bigText,),
          ),
        ),
      ],
    );
  }
}