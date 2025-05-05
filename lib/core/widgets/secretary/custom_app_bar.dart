import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_text_info.dart';
import '../text_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key, required this.title, this.showSearchField, this.textFirstButton, this.showFirstButton, this.showButtonIcon, this.textSecondButton, this.showSecondButton, required this.onPressedFirst, required this.onPressedSecond,
  });

  final String title;
  final bool? showSearchField;
  final String? textFirstButton;
  final bool? showFirstButton;
  final bool? showButtonIcon;
  final String? textSecondButton;
  final bool? showSecondButton;
  final Function onPressedFirst;
  final Function onPressedSecond;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 50.0.w),
          child: Text(
            title,
            style: Styles.h2Bold(color: AppColors.blue),
          ),
        ),
        SizedBox(height: 47.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showSearchField ?? false ? CustomTextInfo(
                textAddress: 'Search here...',
                text: '',
                width: 199.96.w,
                height: 53.h,
                borderRadius: 24.67,
                borderColor: Colors.transparent,
                color: AppColors.highlightPurple,
              ) : SizedBox(width: 0.0,),
              Row(
                children: [
                  showFirstButton ?? false ? TextIconButton(
                    textButton: textFirstButton ?? '',
                    textColor: AppColors.purple,
                    //buttonMinWidth: 125.36,
                    buttonHeight: 53.h,
                    icon: Icons.keyboard_arrow_down,
                    iconSize: 30.01.r,
                    iconColor: AppColors.purple,
                    borderRadius: 24.67,
                    buttonColor: AppColors.white,
                    iconLast: true,
                    showButtonIcon: showButtonIcon,
                    onPressed: (){
                      onPressedFirst();
                    },
                  ) : SizedBox(width: 0.0,),
                  SizedBox(width: 14.0.w,),
                  showSecondButton ?? false ? TextIconButton(
                    textButton: textSecondButton ?? '',
                    buttonHeight: 53.h,
                    icon: Icons.add,
                    iconSize: 30.01.r,
                    borderRadius: 24.67,
                    iconLast: false,
                    showButtonIcon: showButtonIcon,
                    onPressed: (){
                      onPressedSecond();
                    },
                  ) : SizedBox(width: 0.0,),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 171.h,),
      ],
    );
  }
}