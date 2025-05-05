import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.icon, this.color, this.backgroundColor, this.size, this.radius, required this.onTap});

  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final double? size;
  final double? radius;
  final Function onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: CircleAvatar(
          backgroundColor:backgroundColor?? AppColors.purple,
          radius: radius ?? 19.r,
          child:Icon(
            icon,
            color:color?? AppColors.white,
            size: size ?? 22.r,)
      ),
    );
  }
}