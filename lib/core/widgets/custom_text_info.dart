import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/styles.dart';

class CustomTextInfo extends StatelessWidget {
  const CustomTextInfo({super.key, this.height, this.width, this.color, this.borderRadius, this.borderColor, this.textPadding, required this.textAddress, required this.text,
  });

  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? textPadding;
  final String textAddress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: height ?? 50.0.h,
        width: width ?? MediaQuery.of(context).size.width * .8,
        decoration: BoxDecoration(
          color: color ?? Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6.0.r)),
          border: Border.all(color: borderColor ?? Colors.grey.shade300),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: textPadding ?? 19.73.w),
          child: Row(
            children: [
              Icon(
                Icons.search_outlined,
                color: AppColors.purple,
                size: 19.73.r,
              ),
              SizedBox(width: 9.87.w,),
              Expanded(
                child: Text(
                  textAddress,
                  style: Styles.l2Medium(color: AppColors.t1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}