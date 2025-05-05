import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconBoxInformation extends StatelessWidget {
  const CustomIconBoxInformation({super.key, required this.toolTipText, required this.icon});

  final String toolTipText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: toolTipText,
      child: Container(
        width: 55.8.w,
        height: 55.8.w,
        decoration: BoxDecoration(
          color: AppColors.darkHighlightPurple,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: AppColors.t1,
          size: 40.r,
        ),
      ),
    );
  }
}