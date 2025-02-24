import 'package:flutter/material.dart';

class AppConst {
  const AppConst._();

  static const double kNavIconSize = 25;
  static const double kActiveNavIconSize = 35;
  static const double kCardPadding = 16;
  static const double kCardIconSize = 15;
}

class AppColor {
  const AppColor._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF595959);
  static const Color grey = Color(0xFF222222);
  static const Color lightGrey = Color(0xFFE9E9E9);
  static const Color boxGrey = Color(0xFF9E9E9E);
  static const Color error = Color(0xFF771305);

  static const Color darkGreen = Color(0xFF70887A);
  static const Color lightGreen = Color(0xFFA6b69C);
  static const Color darkRose = Color(0xFFD99F8E);
  static const Color lightRose = Color(0xFFF1B79A);
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

class AppFontSize {
  const AppFontSize._();

  static const double s11 = 11;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s17 = 17;
  static const double s18 = 18;
  static const double s19 = 19;
  static const double s21 = 21;
  static const double s23 = 22;

  double scaleSize(BuildContext context, double size) {
    /// Base screen width used in your design
    /// use:
    /// style: TextStyle(fontSize: scaleSize(context, 16)),
    const baseWidth = 375.0;
    final screenWidth = MediaQuery.of(context).size.width;
    return size * (screenWidth / baseWidth);
  }
}
