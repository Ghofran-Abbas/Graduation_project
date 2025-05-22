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
}




