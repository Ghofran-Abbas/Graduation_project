import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEditTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final String? hintText;
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

  const CustomEditTextField({
    super.key,
    this.height,
    this.width,
    this.controller,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.obscureText,
    required this.onPressed,
    required this.onTap,
    required this.onFieldSubmitted,
    this.enabled,
    this.suffixSize,
    this.textCapitalization,
    this.readOnly, this.maxLines,
  });

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
            color: AppColors.t1,
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.t1,
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        hintText: hintText ?? '',
        hintStyle: Styles.l1Normal(color: AppColors.t0,),
        contentPadding: const EdgeInsetsDirectional.only(
          start: 16.0,
          bottom: 16.0,
        ),
        /*floatingLabelStyle: TextStyle(
          color: Colors.grey[400],
        ),*/
        suffixIcon: suffixIcon != null ? IconButton(onPressed: (){ onPressed();}, icon: Icon(suffixIcon, size: suffixSize ?? 25,
          color: AppColors.blue,)) : null,),
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
              return 'this field must not be empty';
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
