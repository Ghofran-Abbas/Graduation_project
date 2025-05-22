import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_text_form_field.dart';

class CustomLabelTextFormField extends StatelessWidget {
  const CustomLabelTextFormField({super.key, this.topPadding, this.bottomPadding, this.leftPadding, this.rightPadding, this.labelText, this.showLabelText, this.hintText, required this.controller, this.onTap, this.onFieldSubmitted, this.onPressed, this.readOnly, this.boxHeight, this.maxLines, this.validator,});

  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final String? labelText;
  final bool? showLabelText;
  final String? hintText;
  final TextEditingController controller;
  final Function? onTap;
  final Function? onFieldSubmitted;
  final Function? onPressed;
  final bool? readOnly;
  final double? boxHeight;
  final int? maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 70.h, bottom: bottomPadding ?? 70.h, left: leftPadding ?? 60.w, right: rightPadding ?? 155.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showLabelText ?? false ? Padding(
            padding: EdgeInsets.only(left: 0.w, bottom: 4.h),
            child: Text(
              labelText ?? '',
              style: Styles.l1Normal(color: AppColors.t2),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ) : SizedBox(width: 0.w, height: 0.h,),
          SizedBox(
            height: boxHeight ?? 55.h,
            child: CustomTextFormField(
              hintText: hintText ?? '',
              readOnly: readOnly ?? false,
              controller: controller,
              maxLines: maxLines,
              onTap: onTap ?? (){},
              onFieldSubmitted: onFieldSubmitted ?? (){},
              onPressed: onPressed ?? (){},
              validator: validator ??
                      (value) {
                    if (value?.isEmpty ?? true) {
                      return AppLocalizations.of(context).translate('this field must not be empty');
                    }
                    return null;
                  },
            ),
          ),
        ],
      ),
    );
  }
}