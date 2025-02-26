import 'package:flutter/material.dart';

class AppConst {
  const AppConst._();

  static const double kNavIconSize = 25;
  static const double kActiveNavIconSize = 35;
  static const double kCardPadding = 16;
  static const double kCardIconSize = 15;
  static const double kBorderRadius = 4;
}

class AppColor {
  const AppColor._();

  static const Color black = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF595959);
  static const Color grey = Color(0xFF222222);
  static const Color lightGrey = Color(0xFFE9E9E9);
  static const Color boxGrey = Color(0xFF9E9E9E);
  static const Color error = Color(0xFF771305);
  static const Color background = Color(0xFFFEEBDC);

  static const Color darkBrown = Color(0xFF793e25);
  static const Color lightBrown = Color(0xFF935f46);
  static const Color darkYellow = Color(0xFFbf793d);
  static const Color lightYellow = Color(0xFFf6bd88);
  static const Color darkGreen = Color(0xFF6D6A4B);
  static const Color lightGreen = Color(0xFFaaa27e);
  static const Color purple = Color(0xFF915d52);
  static const Color creme = Color(0xFFf8fdf9);
}

class AppFont {
  const AppFont._();

  static const poppins = 'Poppins';
  static const aeonik = 'Aeonik';
}

class AppFontWeight {
  const AppFontWeight._();

  static const FontWeight light = FontWeight.w300;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
