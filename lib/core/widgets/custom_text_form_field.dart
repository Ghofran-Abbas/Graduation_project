import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../localization/app_localizations.dart';

class CustomTextFormField extends StatelessWidget {

  const CustomTextFormField({
    super.key, this.height, this.width, this.controller, this.hintText, this.validator, this.suffixIcon, this.obscureText, required this.onPressed, required this.onTap, required this.onFieldSubmitted, this.enabled, this.suffixSize, this.textCapitalization, this.readOnly, this.maxLines, this.hintTextStyle, this.borderRadius, this.contentPadding, this.borderColor, this.filled, this.fillColor, this.prefixIcon, this.prefixSize, this.onPressedPrefix,
  });

  final double? height;
  final double? width;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function onPressed;
  final Function onTap;
  final Function onFieldSubmitted;
  final bool? enabled;
  final bool? readOnly;
  final double? suffixSize;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final double? borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final IconData? prefixIcon;
  final double? prefixSize;
  final Function? onPressedPrefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      enabled: enabled,
      textAlign: TextAlign.start,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? AppColors.t1,
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? AppColors.t1,
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.r)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.r)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.r)),
        ),
        filled: filled ?? true,
        fillColor: fillColor ?? AppColors.white,
        hintText: hintText ?? '',
        hintStyle: hintTextStyle ?? Styles.l1Normal(color: AppColors.t0,),
        contentPadding: contentPadding ?? const EdgeInsetsDirectional.only(
          start: 16.0,
          bottom: 16.0,
        ),
        /*floatingLabelStyle: TextStyle(
          color: Colors.grey[400],
        ),*/
        suffixIcon: suffixIcon != null ? IconButton(onPressed: (){ onPressed();}, icon: Icon(suffixIcon, size: suffixSize ?? 25,
          color: AppColors.blue,)) : null,
        prefixIcon: prefixIcon != null ? IconButton(onPressed: (){ onPressedPrefix!() ?? () {};}, icon: Icon(prefixIcon, size: prefixSize ?? 25,
          color: AppColors.blue,)) : null,
      ),
      obscureText: obscureText ?? false,
      //initialValue: initialValue,
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      cursorColor: AppColors.t1,
      validator: validator ??
              (value) {
            if (value?.isEmpty ?? true) {
              return AppLocalizations.of(context).translate('this field must not be empty');
            }
            return null;
          },
      onTap: (){
        onTap();
      },
      onFieldSubmitted: (value){
        onFieldSubmitted(value);
      },
    );
  }
}

class CustomFilePickerField extends StatelessWidget {
  const CustomFilePickerField({
    super.key,
    this.height,
    this.width,
    this.fileName,
    this.hintText,
    this.hintTextStyle,
    this.borderRadius,
    this.borderColor,
    this.contentPadding,
    this.filled,
    this.fillColor,
    this.suffixIcon,
    this.suffixSize,
    required this.pickFile,
  });

  final double? height;
  final double? width;
  final String? fileName;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final IconData? suffixIcon;
  final double? suffixSize;
  final Function pickFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {pickFile();},
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.t1,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.t1,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
            ),
            filled: filled ?? true,
            fillColor: fillColor ?? AppColors.white,
            hintText: fileName ?? hintText ?? '',
            hintStyle: hintTextStyle ?? Styles.l1Normal(color: AppColors.t0),
            contentPadding: contentPadding ?? const EdgeInsetsDirectional.only(
              start: 16.0,
              bottom: 16.0,
            ),
            prefixIcon: suffixIcon != null
                ? Icon(suffixIcon, size: suffixSize ?? 24, color: AppColors.t1)
                : Icon(Icons.cloud_upload_outlined, size: 24, color: AppColors.t1),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
