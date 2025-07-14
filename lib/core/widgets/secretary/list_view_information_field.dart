import 'package:alhadara_dashboard/core/widgets/custom_error_widget.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/trainers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/secretary_features/student/data/models/students_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_icon_button.dart';
import '../custom_image_network.dart';

/*class ListViewInformationField extends StatelessWidget {
  const ListViewInformationField({
    super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.widthProfileText, required this.name, this.nameColor, this.showDetailsText, this.secondText, this.secondTextColor, this.showSecondDetailsText, this.thirdDetailsText, this.thirdDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, this.fourthDetailsText, this.fourthDetailsTextColor, required this.itemCount, this.students, this.trainers,
  });

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
  final List<Datum>? students;
  final List<DatumTrainer>? trainers;

  @override
  Widget build(BuildContext context) {
    bool? isStudents;
    List<dynamic>? items;
    if(students != null) {
      isStudents = true;
      items = students;
    } else if(trainers != null) {
      isStudents = false;
      items = trainers;
    }
    return items != null ? ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Align(child: InformationFieldItem(
          width: width,
          height: height,
          color: index%2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
          image: image,
          imageWidth: imageWidth,
          imageHeight: imageHeight,
          imageBorderRadius: imageBorderRadius,
          widthProfileText: widthProfileText,
          name: name,
          nameColor: nameColor,
          showDetailsText: showDetailsText,
          secondText: secondText,
          secondTextColor: secondTextColor,
          showSecondDetailsText: showSecondDetailsText,
          thirdDetailsText: thirdDetailsText,
          thirdDetailsTextColor: thirdDetailsTextColor,
          fourthDetailsText: fourthDetailsText,
          fourthDetailsTextColor: fourthDetailsTextColor,
          showIcons: showIcons,
          heightTextIcon: heightTextIcon,
          leftIcon: leftIcon,
          rightIcon: rightIcon,
          onTap: (){onTap();},
        ));
      },
      itemCount: itemCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    ) : CustomErrorWidget(errorMessage: 'No thing to display');
  }
}*/

class InformationFieldItem extends StatelessWidget {
  const InformationFieldItem({
    super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.widthProfileText, required this.name, this.nameColor, this.showDetailsText, this.secondText, this.secondTextColor, this.showSecondDetailsText, this.thirdDetailsText, this.thirdDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, this.fourthDetailsText, this.fourthDetailsTextColor, required this.onTapFirstIcon, required this.onTapSecondIcon, this.fifthText, this.fifthTextColor, this.showFifthDetailsText, this.showJustTowDetailsText, this.showFirstBox, this.hideFirstIcon, this.showSecondBox, this.hideSecondIcon, this.onTapFirstBox, this.onTapSecondBox, this.isReportStyle, this.hideFirstBox,
  });

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
  final String? fifthText;
  final Color? fifthTextColor;
  final bool? showFifthDetailsText;
  final bool? showJustTowDetailsText;
  final bool? showIcons;
  final bool? hideFirstIcon;
  final bool? hideSecondIcon;
  final double? heightTextIcon;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Function onTap;
  final Function onTapFirstIcon;
  final Function onTapSecondIcon;
  final Function? onTapFirstBox;
  final Function? onTapSecondBox;
  final bool? showFirstBox;
  final bool? hideFirstBox;
  final bool? showSecondBox;
  final bool? isReportStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(left: 7.0.w, right: 37.0.w),
        width: width ?? 1151.24.w,
        height: height ?? 66.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
        ),
        child: isReportStyle ?? false ? Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  //image
                  image != null ? CustomImageNetwork(
                    imageWidth: imageWidth ?? 24.w,
                    imageHeight: imageHeight ?? 24.w,
                    borderRadius: imageBorderRadius ?? 30.r,
                    image: image,
                  ) : CustomImageAsset(
                    imageWidth: imageWidth ?? 24.w,
                    imageHeight: imageHeight ?? 24.w,
                    borderRadius: imageBorderRadius ?? 30.r,
                  ),
                  //Information
                  SizedBox(width: widthProfileText ?? 8.12.w,),
                  Expanded(
                    child: Text(
                      name,
                      style: Styles.l2Medium(color: nameColor ?? AppColors.t3),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              flex: 8,
              child: Text(
                secondText ?? '',
                style: Styles.l2Medium(color: secondTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 30.w,),
            Expanded(
              flex: 1,
              child: Text(
                fifthText ?? '',
                style: Styles.l2Medium(color: fifthTextColor ?? AppColors.darkLightPurple),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            //Action icons
            SizedBox(width: 20.0.h,),
            showIcons ?? false ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hideFirstIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: leftIcon ?? Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                SizedBox(width: 10.8.w,),
                hideSecondIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: rightIcon ?? Icons.delete_outline, onTap: (){onTapSecondIcon();},),
              ],
            ) : SizedBox(width: 0, height: 0,),
          ],
        ) : Row(
          children: [
            Expanded(
              flex: showFirstBox ?? false ? (showFifthDetailsText ?? false ? 2 : (showSecondBox ?? false ? 2 : 1)) : (hideFirstBox ?? false ? 2 : 1),
              child: Row(
                children: [
                  showFirstBox ?? false ? buildCheckOption(
                    borderColor: AppColors.t2,
                    icon: Icons.check,
                    iconColor: AppColors.t2,
                    isSelected: false,
                    onTap: (){onTapFirstBox!() ?? () {};},
                  ) : SizedBox(width: 0.w, height: 0.h,),
                  showSecondBox ?? false ? SizedBox(width: 8.w,) : SizedBox(width: 0.w, height: 0.h,),
                  showSecondBox ?? false ? buildCheckOption(
                    borderColor: AppColors.t2,
                    icon: Icons.close,
                    iconColor: AppColors.t2,
                    isSelected: false,
                    onTap: (){onTapFirstBox!() ?? () {};},
                  ) : SizedBox(width: 0.w, height: 0.h,),
                  showFirstBox ?? false ? SizedBox(width: showSecondBox ?? false ? 15.w : 10.w,) : SizedBox(width: 0.w, height: 0.h,),
                  //image
                  image != null ? CustomImageNetwork(
                    imageWidth: imageWidth ?? 24.w,
                    imageHeight: imageHeight ?? 24.w,
                    borderRadius: imageBorderRadius ?? 30.r,
                    image: image,
                  ) : CustomImageAsset(
                    imageWidth: imageWidth ?? 24.w,
                    imageHeight: imageHeight ?? 24.w,
                    borderRadius: imageBorderRadius ?? 30.r,
                  ),
                  //Information
                  SizedBox(width: widthProfileText ?? 8.12.w,),
                  Expanded(
                    child: Text(
                      name,
                      style: Styles.l2Medium(color: nameColor ?? AppColors.t3),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            showSecondDetailsText ?? false ? SizedBox(width: 80.w,) : SizedBox(width: 0.w, height: 0.h,),
            showSecondDetailsText ?? false ? Expanded(
              flex: 1,
              child: Text(
                secondText ?? '',
                style: Styles.l2Medium(color: secondTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ) : SizedBox(width: 0.w, height: 0.h,),
            SizedBox(width: 50.w,),
            Expanded(
              flex: showJustTowDetailsText ?? false ? 3 : 2,
              child: Text(
                thirdDetailsText ?? '',
                style: Styles.l2Medium(color: thirdDetailsTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 50.w,),
            Expanded(
              flex: 1,
              child: Text(
                fourthDetailsText ?? '',
                style: Styles.l2Medium(color: fourthDetailsTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            showFifthDetailsText ?? false ? SizedBox(width: 50.w,) : SizedBox(width: 0.w, height: 0.h,),
            showFifthDetailsText ?? false ? Expanded(
              flex: 1,
              child: Text(
                fifthText ?? 'Complete',
                style: Styles.l2Medium(color: fifthTextColor ?? AppColors.mintGreen),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ) : SizedBox(width: 0.w, height: 0.h,),
            //Action icons
            SizedBox(width: 50.0.h,),
            showIcons ?? false ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hideFirstIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: leftIcon ?? Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                SizedBox(width: 10.8.w,),
                hideSecondIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: rightIcon ?? Icons.delete_outline, onTap: (){onTapSecondIcon();},),
              ],
            ) : SizedBox(width: 0, height: 0,),
            showIcons ?? false ? SizedBox(width: 0.w,) : SizedBox(width: showFifthDetailsText ?? false ? 0.w : 70.w),
          ],
        ),
      ),
    );
  }
}

Widget buildCheckOption({
  required bool isSelected,
  required IconData icon,
  required Color borderColor,
  required Color iconColor,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 25.r,
      height: 25.r,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.w),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Icon(icon, size: 16.0, color: isSelected ? AppColors.mintGreen : iconColor),
    ),
  );
}

class RatingFieldItem extends StatelessWidget {
  const RatingFieldItem({super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.widthProfileText, required this.name, this.nameColor, this.onTap, required this.rating, required this.dateText, this.dataColor, required this.commentText, this.commentColor});

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
  final int rating;
  final String dateText;
  final Color? dataColor;
  final String commentText;
  final Color? commentColor;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap!() ?? () {};
      },
      child: Container(
        padding: EdgeInsets.only(left: 7.0.w, right: 37.0.w),
        width: width ?? 1151.24.w,
        height: height ?? 180.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h.clamp(10, 100),),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      image != null ? CustomImageNetwork(
                        imageWidth: imageWidth ?? 24.w.clamp(24, 30),
                        imageHeight: imageHeight ?? 24.w.clamp(24, 30),
                        borderRadius: imageBorderRadius ?? 30.r,
                        image: image,
                      ) : CustomImageAsset(
                        imageWidth: imageWidth ?? 24.w.clamp(24, 30),
                        imageHeight: imageHeight ?? 24.w.clamp(24, 30),
                        borderRadius: imageBorderRadius ?? 30.r,
                      ),
                      //Information
                      SizedBox(width: widthProfileText ?? 25.w.clamp(20, 30),),
                      Expanded(
                        child: Text(
                          name,
                          style: Styles.l1Normal(color: nameColor ?? AppColors.t3),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h.clamp(25, 100),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ReadOnlyRatingStars(
                  rating: rating,
                ),
                SizedBox(width: 20.w.clamp(20, 30),),
                Expanded(
                  child: Text(
                    dateText,
                    style: Styles.l2Medium(color: dataColor ?? AppColors.t3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h.clamp(10, 60),),
            Expanded(
              child: Text(
                commentText,
                style: Styles.l1Normal(color: commentColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10.h.clamp(10, 60),),
          ],
        ),
      ),
    );
  }
}

class ReadOnlyRatingStars extends StatelessWidget {
  final int rating;
  final double size;
  final Color filledColor;
  final Color emptyColor;

  const ReadOnlyRatingStars({
    super.key,
    required this.rating,
    this.size = 18,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final int fullStars = rating.floor();
    final bool hasHalfStar = (rating - fullStars) >= 0.5;
    final int totalStars = 5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalStars, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, size: size.sp.clamp(15, 30), color: filledColor);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, size: size.sp.clamp(15, 30), color: filledColor);
        } else {
          return Icon(Icons.star_border, size: size.sp.clamp(15, 30), color: emptyColor);
        }
      }),
    );
  }
}