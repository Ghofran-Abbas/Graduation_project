import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:alhadara_dashboard/core/widgets/custom_icon_button.dart';
import 'package:alhadara_dashboard/core/widgets/secretary/custom_overloading_avatar.dart';
import 'package:alhadara_dashboard/core/widgets/secretary/custom_about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/secretary/custom_information_field.dart';
import 'custom_icon_box_information.dart';

class CustomProfileInformation extends StatelessWidget {
  const CustomProfileInformation({super.key, this.image, this.imageWidth, this.imageHeight, this.borderRadius, required this.name, this.detailsText, this.showDetailsText, required this.firstBoxText, required this.firstBoxIcon, required this.secondBoxText, required this.secondBoxIcon, this.aboutText, this.showAboutText, this.firstFieldInfoTitle, required this.firstFieldInfoText, this.secondFieldInfoTitle, required this.secondFieldInfoText, this.thirdFieldInfoTitle, this.thirdFieldInfoText, this.showThirdFieldInfo, this.showThirdFieldInfoIcon, required this.labelText, this.firstImage, this.secondImage, this.thirdImage, this.fourthImage, this.fifthImage, required this.tailText, this.showOverloadingAvatar, required this.avatarCount, required this.onTap});

  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final double? borderRadius;
  final String name;
  final String? detailsText;
  final bool? showDetailsText;
  final String firstBoxText;
  final IconData firstBoxIcon;
  final String secondBoxText;
  final IconData secondBoxIcon;
  final String? aboutText;
  final bool? showAboutText;
  final String? firstFieldInfoTitle;
  final String firstFieldInfoText;
  final String? secondFieldInfoTitle;
  final String secondFieldInfoText;
  final String? thirdFieldInfoTitle;
  final String? thirdFieldInfoText;
  final bool? showThirdFieldInfo;
  final bool? showThirdFieldInfoIcon;
  final String labelText;
  final Color? firstImage;
  final Color? secondImage;
  final Color? thirdImage;
  final Color? fourthImage;
  final Color? fifthImage;
  final String tailText;
  final int avatarCount;
  final bool? showOverloadingAvatar;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 20.h, left: 118.w, right: 50.w,),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != null ? CustomImageNetwork(
                image: image,
                imageWidth: imageWidth ?? 252.w,
                imageHeight: imageHeight ?? 252.w,
                borderRadius: borderRadius ?? 210.r,
              ) : CustomImageAsset(
                imageWidth: imageWidth ?? 252.w,
                imageHeight: imageHeight ?? 252.w,
                borderRadius: borderRadius ?? 210.r,
              ),
              SizedBox(height: 65.h,),
              Text(
                name,
                style: Styles.b2Bold(color: AppColors.t4),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: showDetailsText ?? false ? 5.h : 0.h,),
              showDetailsText ?? false ? Text(
                detailsText ?? '',
                style: Styles.l1Bold(color: AppColors.t1),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ) : SizedBox(width: 0.w, height: 0.h,),
              SizedBox(height: showDetailsText ?? false ? 45.h : 79.h,),
              Row(
                children: [
                  CustomIconBoxInformation(
                    toolTipText: firstBoxText,
                    icon: firstBoxIcon,
                  ),
                  SizedBox(width: 22.w,),
                  CustomIconBoxInformation(
                    toolTipText: secondBoxText,
                    icon: secondBoxIcon,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 186.w,),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showAboutText ?? false ? CustomAbout(
                labelText: 'About',
                bodyText: aboutText ?? '',
              ) : SizedBox(width: 0.w, height: 0.w,),
              //showAboutText ?? false ? SizedBox(height: 75.h) : SizedBox(width: 0.w, height: 0.w,),
              SizedBox(height: showAboutText ?? false ? 75.h : 405.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomInformationField(title: firstFieldInfoTitle ?? 'Birth date', textBody: firstFieldInfoText),
                  SizedBox(width: 73.w,),
                  CustomInformationField(title: secondFieldInfoTitle ?? 'Gender', textBody: secondFieldInfoText),
                  SizedBox(width: 73.w,),
                  showThirdFieldInfo ?? false ? CustomInformationField(title: thirdFieldInfoTitle ?? 'Points', textBody: thirdFieldInfoText ?? '') : SizedBox(width: 0.w, height: 0.w,),
                  showThirdFieldInfoIcon ?? false ? SizedBox(width: 15.w,) : SizedBox(width: 0.w, height: 0.w,),
                  showThirdFieldInfoIcon ?? false ? CustomIconButton(
                    icon: Icons.edit,
                    onTap: (){onTap();},
                  ) : SizedBox(width: 0.w, height: 0.w,),
                ],
              ),
              SizedBox(height: 52.h,),
              CustomOverloadingAvatar(
                labelText: labelText,
                firstImage: firstImage,
                secondImage: secondImage,
                thirdImage: thirdImage,
                fourthImage: fourthImage,
                fifthImage: fifthImage,
                tailText: tailText,
                avatarCount: avatarCount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}