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
    super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.widthProfileText, required this.name, this.nameColor, this.showDetailsText, this.secondText, this.secondTextColor, this.showSecondDetailsText, this.thirdDetailsText, this.thirdDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, this.fourthDetailsText, this.fourthDetailsTextColor, required this.onTapFirstIcon, required this.onTapSecondIcon,
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
  final Function onTapFirstIcon;
  final Function onTapSecondIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(left: 7.0.w, right: 37.0.w),
        //padding: EdgeInsets.only(top: 20.0.h, bottom: 0.0.h, left: 20.0.w, right: 20.0.w),
        width: width ?? 1151.24.w,
        height: height ?? 66.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
        ),
        child: Row(
          //mainAxisAlignment: (showDetailsText ?? false) && (showIcons ?? false) ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            //image
            CustomImageNetwork(
              imageWidth: imageWidth ?? 24.w,
              imageHeight: imageHeight ?? 24.w,
              borderRadius: imageBorderRadius ?? 30.r,
              image: image,
            ),
            //Information
            SizedBox(width: widthProfileText ?? 8.12.w,),
            Expanded(
              flex: 1,
              child: Text(
                name,
                style: Styles.l2Medium(color: nameColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 50.w,),
            Expanded(
              flex: 1,
              child: Text(
                secondText ?? '',
                style: Styles.l2Medium(color: secondTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 50.w,),
            Expanded(
              flex: 2,
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
            //Action icons
            SizedBox(width: 50.0.h,),
            showIcons ?? false ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(icon: leftIcon ?? Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                SizedBox(width: 10.8.w,),
                CustomIconButton(icon: rightIcon ?? Icons.delete_outline, onTap: (){onTapSecondIcon();},),
              ],
            ) : SizedBox(width: 0, height: 0,),
          ],
        ),
      ),
    );
  }
}