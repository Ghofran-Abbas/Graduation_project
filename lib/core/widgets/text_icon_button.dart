import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/styles.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({super.key, this.borderRadius, this.buttonColor, required this.textButton, this.textColor, this.textWeight, this.textSize, this.icon, this.iconColor, this.iconSize, this.buttonHeight, required this.onPressed, this.borderWidth, this.borderColor, required this.iconLast, this.showButtonIcon, this.bigText, this.firstSpaceBetween,});

  final double? borderRadius;
  final Color? buttonColor;
  final double? borderWidth;
  final Color? borderColor;
  final String textButton;
  final Color? textColor;
  final FontWeight? textWeight;
  final double? textSize;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? buttonHeight;
  final Function onPressed;
  final bool iconLast;
  final bool? showButtonIcon;
  final bool? bigText;
  final double? firstSpaceBetween;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      //stepWidth: buttonMinWidth ?? 0,
      child: SizedBox(
        height: buttonHeight ?? MediaQuery.of(context).size.height * .065,
        child: Material(
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(borderRadius ?? 22.0.r),side: BorderSide(color: borderColor ?? AppColors.purple, width: borderWidth ?? 1.23,) ),
          clipBehavior: Clip.antiAlias,
          color: buttonColor ?? AppColors.purple,
          child: MaterialButton(
            onPressed: (){
              onPressed();
            },
            padding: EdgeInsets.symmetric(horizontal: 20.52.w, vertical: 9.87.h),
            child: Row(
              children: [
                !iconLast ? icon == null ? const SizedBox(height: 0,width: 0,) : Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: iconSize ?? 23.r,
                ) : SizedBox(height: 0,width: 0,),
                !iconLast ? SizedBox(width: 0.w,) : SizedBox(width: firstSpaceBetween ?? 10.0.w,),
                Expanded(
                  child: Text(
                    textButton,
                    style: bigText ?? false ? Styles.l1Normal(color: textColor ?? AppColors.white) : Styles.l2Medium(color: textColor ?? AppColors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                showButtonIcon ?? false ? iconLast ? SizedBox(width: 10.0.w,) : SizedBox(height: 0,width: 0,) : SizedBox(height: 0,width: 0,),
                showButtonIcon ?? false ? iconLast ? icon == null ? const SizedBox(height: 0,width: 0,) : Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: iconSize ?? 23.r,
                ) : SizedBox(height: 0,width: 0,) : SizedBox(height: 0,width: 0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}