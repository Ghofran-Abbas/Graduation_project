import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_app_bar.dart';

class CustomScreenBody extends StatelessWidget {
  const CustomScreenBody({
    super.key, required this.body, required this.title, this.showSearchField, this.textFirstButton, this.showFirstButton, this.showButtonIcon, this.textSecondButton, this.showSecondButton, required this.onPressedFirst, required this.onPressedSecond,
  });

  final String title;
  final bool? showSearchField;
  final String? textFirstButton;
  final bool? showFirstButton;
  final bool? showButtonIcon;
  final String? textSecondButton;
  final bool? showSecondButton;
  final Widget body;
  final Function onPressedFirst;
  final Function onPressedSecond;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1143.w,
      child: Stack(
        children: [
          Container(height: 171.h,),
          body,
          CustomAppBar(
            title: title,
            showSearchField: showSearchField,
            textFirstButton: textFirstButton,
            showFirstButton: showFirstButton,
            showButtonIcon: showButtonIcon,
            textSecondButton: textSecondButton,
            showSecondButton: showSecondButton,
            onPressedFirst: (){
              onPressedFirst();
            },
            onPressedSecond: (){
              onPressedSecond();
            },
          ),
        ],
      ),
    );
  }
}