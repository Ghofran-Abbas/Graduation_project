import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';

class CustomDropdownList extends StatelessWidget {
  const CustomDropdownList({super.key, required this.hintText, this.maxHeight, this.borderRadius, this.borderColor, this.borderWidth, this.menuBorderColor, this.menuWidth, this.menuBorderWidth, required this.statusController, required this.dropdownMenuEntries, this.topPadding, this.bottomPadding});

  final String hintText;
  final double? maxHeight;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Color? menuBorderColor;
  final double? menuWidth;
  final double? menuBorderWidth;
  final double? topPadding;
  final double? bottomPadding;
  final TextEditingController statusController;
  final List<DropdownMenuEntry<dynamic>> dropdownMenuEntries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 72.h, bottom: bottomPadding ?? 38.h),
      child: DropdownMenu(
        enableSearch: false,
        requestFocusOnTap: false,
        width: menuWidth ?? 150.w,
        hintText: hintText,
        inputDecorationTheme: InputDecorationTheme(
          constraints: BoxConstraints(
            maxHeight: maxHeight ?? 55.h,
          ),
          hintStyle: Styles.l1Normal(color: AppColors.t0,),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? AppColors.t1,
              width: borderWidth ?? .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.gold,
              width: borderWidth ?? .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
              width: borderWidth ?? .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.r)),
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateColor.resolveWith(
                (states) {
              return AppColors.white;
            },
          ),
          side: WidgetStateBorderSide.resolveWith(
                (states) {
              return BorderSide(
                color: menuBorderColor ?? AppColors.t1,
                width: menuBorderWidth ?? .5,
              );
            },
          ),
          shape: WidgetStateOutlinedBorder.resolveWith(
                (states) {
              return BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(0.r), topRight: Radius.circular(0.r), bottomRight: Radius.circular(borderRadius ?? 4.r), bottomLeft: Radius.circular(borderRadius ?? 4.r))
              );
            },
          ),
        ),
        controller: statusController,
        dropdownMenuEntries: dropdownMenuEntries,
      ),
    );
  }
}