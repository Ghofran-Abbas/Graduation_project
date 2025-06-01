import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';

class CustomInformationField extends StatelessWidget {
  const CustomInformationField({super.key, required this.title, required this.textBody});

  final String title;
  final String textBody;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.l2Bold(color: AppColors.t4),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 14.h,),
          Text(
            textBody,
            style: Styles.l1Normal(color: AppColors.t1),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}