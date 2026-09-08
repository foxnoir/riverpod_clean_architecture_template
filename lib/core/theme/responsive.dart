import 'package:flutter/widgets.dart';

class Responsive {
  const Responsive._();

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600 &&
      MediaQuery.of(context).size.shortestSide < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 1200;
}
