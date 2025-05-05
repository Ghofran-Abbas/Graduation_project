import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';

class CustomAbout extends StatelessWidget {
  const CustomAbout({super.key, this.labelText, required this.bodyText, this.bigText});

  final String? labelText;
  final String bodyText;
  final bool? bigText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? 'About',
          style: Styles.b2Bold(color: AppColors.t4),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 16.h,),
        Text(
          bodyText,
          style: bigText ?? false ? Styles.b1Normal(color: AppColors.t1) : Styles.b2Normal(color: AppColors.t1),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}