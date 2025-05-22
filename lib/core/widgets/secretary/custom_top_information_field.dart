import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';

class CustomTopInformationField extends StatelessWidget {
  const CustomTopInformationField({super.key, this.firstIcon, this.firstIconColor, required this.firstText, this.firstTextColor, this.secondIcon, this.secondIconColor, required this.secondText, this.secondTextColor, this.thirdIcon, this.thirdIconColor, required this.thirdText, this.thirdTextColor, this.isTrainer});

  final IconData? firstIcon;
  final Color? firstIconColor;
  final String firstText;
  final Color? firstTextColor;
  final IconData? secondIcon;
  final Color? secondIconColor;
  final String secondText;
  final Color? secondTextColor;
  final IconData? thirdIcon;
  final Color? thirdIconColor;
  final String thirdText;
  final Color? thirdTextColor;
  final bool? isTrainer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                firstIcon ?? Icons.people_outline,
                size: 40.r,
                color: firstIconColor ?? AppColors.mintGreen,
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Text(
                  firstText,
                  style: Styles.l1Bold(color: firstTextColor ?? AppColors.t1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: isTrainer ?? false ? 20.w : 150.w,),
        Expanded(
          child: Row(
            children: [
              Icon(
                secondIcon ?? Icons.lock_clock_outlined,
                size: 40.r,
                color: secondIconColor ?? AppColors.orange,
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Text(
                  secondText,
                  style: Styles.l1Bold(color: secondTextColor ?? AppColors.t1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: isTrainer ?? false ? 120.w : 150.w,),
        Expanded(
          child: Row(
            children: [
              Icon(
                thirdIcon ?? Icons.lock_person_outlined,
                size: 40.r,
                color: thirdIconColor ?? AppColors.purple,
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Text(
                  thirdText,
                  style: Styles.l1Bold(color: thirdTextColor ?? AppColors.t1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: isTrainer ?? false ? 200.w : 250.w,),
      ],
    );
  }
}