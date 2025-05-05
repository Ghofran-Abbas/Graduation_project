import 'package:alhadara_dashboard/core/utils/size.dart';
import 'package:flutter/material.dart';
//import 'app_manager.dart';

class Styles {

//Text size
  // Heading 01
  static TextStyle h1Bold({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.h132,
    );
  }
  // Heading 02
  static TextStyle h2Bold({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.h230,
    );
  }
  // Heading 03
  static TextStyle h3Bold({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.h324,
    );
  }
  // Body 01
  static TextStyle b1Normal({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.b118,
    );
  }
  // Body 02
  static TextStyle b2Bold({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.b216,
    );
  }
  // Body 02
  static TextStyle b2Normal({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.b216,
    );
  }
  // label 01
  static TextStyle l1Normal({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.l114,
    );
  }
  // label 01
  static TextStyle l1Bold({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.l114,
    );
  }
  // label 02
  static TextStyle l2Medium({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.l2121,
    );
  }
  // label 02
  static TextStyle l2Bold({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.l2121,
    );
  }
  // label 03
  static TextStyle l3Normal({
    Color? color,
    double? size,
    FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size ?? AppSize.l310,
    );
  }


/*// Heading 01
  static TextStyle h1Bold({
        Color? color,
       double size = AppSize.s30,
       FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h1SemiBold({
        Color? color,
       double size = AppSize.s30,
       FontWeight fontWeight = FontWeight.w600,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h1Medium({
        Color? color,
       double size = AppSize.s30,
       FontWeight fontWeight = FontWeight.w500,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h1Regular({
        Color? color,
       double size = AppSize.s30,
       FontWeight fontWeight = FontWeight.normal,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }



// Heading 02
  static TextStyle h2Bold({
        Color? color,
       double size = AppSize.s26,
       FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }
 
  static TextStyle h2SemiBold({
        Color? color,
       double size = AppSize.s26,
       FontWeight fontWeight = FontWeight.w600,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h2Medium({
        Color? color,
       double size = AppSize.s26,
       FontWeight fontWeight = FontWeight.w500,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h2Regular({
        Color? color,
       double size = AppSize.s26,
       FontWeight fontWeight = FontWeight.normal,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  
// Heading 03
  static TextStyle h3Bold({
        Color? color,
       double size = AppSize.s20,
       FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h3SemiBold({
        Color? color,
       double size = AppSize.s20,
       FontWeight fontWeight = FontWeight.w600,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h3Medium({
        Color? color,
       double size = AppSize.s20,
       FontWeight fontWeight = FontWeight.w500,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h3Regular({
        Color? color,
       double size = AppSize.s20,
       FontWeight fontWeight = FontWeight.normal,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

 
// Heading 04
  static TextStyle h4Bold({
        Color? color,
       double size = AppSize.s18,
       FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h4SemiBold({
        Color? color,
       double size = AppSize.s18,
       FontWeight fontWeight = FontWeight.w600,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h4Medium({
        Color? color,
       double size = AppSize.s18,
       FontWeight fontWeight = FontWeight.w500,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  static TextStyle h4Regular({
        Color? color,
       double size = AppSize.s18,
       FontWeight fontWeight = FontWeight.normal,}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }



/////////////////////////////////
  // Body 01

    static TextStyle body1Bold({
        Color? color,
       double size = AppSize.s16,
       FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }
     static TextStyle body1SemiBold({
        Color? color,
       double size = AppSize.s16,
       FontWeight fontWeight = FontWeight.w600}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }
     
     static TextStyle body1Medium({
        Color? color,
       double size = AppSize.s16,
       FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

     static TextStyle body1Regular({
        Color? color,
       double size = AppSize.s16,
       FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }
  

  // Body 02
 static TextStyle body2SemiBold({
        Color? color,
       double size = AppSize.s14,
       FontWeight fontWeight = FontWeight.w600}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }
     
 static TextStyle body2Medium({
        Color? color,
       double size = AppSize.s14,
       FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

 static TextStyle body2Regular({
        Color? color,
       double size = AppSize.s14,
       FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }
  

////////////////////////////////



// Label
static TextStyle labelMedium({
        Color? color,
       double size = AppSize.s12,
       FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

static TextStyle labelRegular({
        Color? color,
       double size = AppSize.s12,
       FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }




// Button
static TextStyle button1({
        Color? color,
       double size = AppSize.s14,
       FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

static TextStyle button2({
        Color? color,
       double size = AppSize.s12,
       FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }*/

}




