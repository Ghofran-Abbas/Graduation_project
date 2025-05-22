import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_app_bar.dart';

class CustomScreenBody extends StatelessWidget {
  const CustomScreenBody({
    super.key, required this.body, required this.title, this.showSearchField, this.textFirstButton, this.showFirstButton, this.showButtonIcon, this.textSecondButton, this.showSecondButton, required this.onPressedFirst, required this.onPressedSecond, this.widget, this.turnSearch, this.onFieldSubmitted, this.searchController, this.onTapSearch, this.showProfileAvatar,
  });

  final String title;
  final bool? showProfileAvatar;
  final bool? showSearchField;
  final String? textFirstButton;
  final bool? showFirstButton;
  final bool? showButtonIcon;
  final String? textSecondButton;
  final bool? showSecondButton;
  final bool? turnSearch;
  final Widget body;
  final Function onPressedFirst;
  final Function onPressedSecond;
  final Function? onTapSearch;
  final Function? onFieldSubmitted;
  final TextEditingController? searchController;
  final Widget? widget;

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
            showProfileAvatar: showProfileAvatar,
            showSearchField: showSearchField,
            turnSearch: turnSearch,
            textFirstButton: textFirstButton,
            showFirstButton: showFirstButton,
            showButtonIcon: showButtonIcon,
            textSecondButton: textSecondButton,
            showSecondButton: showSecondButton,
            searchController: searchController,
            onPressedFirst: (){
              onPressedFirst();
            },
            onPressedSecond: (){
              onPressedSecond();
            },
            onTapSearch: () {onTapSearch!() ?? () {};},
            onFieldSubmitted: (value){
              onFieldSubmitted!(value) ?? (value) {};
            },
            widget: widget,
          ),
        ],
      ),
    );
  }
}