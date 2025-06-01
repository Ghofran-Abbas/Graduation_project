import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/assets.dart';
import '../../utils/styles.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({super.key, required this.firstText, required this.secondText});

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1100.w,
      height: 540.h,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(Assets.empty)),
          Expanded(
            child: Text(
              firstText,
              style: Styles.h3Bold(color: AppColors.t3),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              secondText,
              style: Styles.l1Normal(color: AppColors.t3),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}