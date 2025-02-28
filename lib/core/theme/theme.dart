import 'package:book_dragon/core/theme/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getLightTheme() {
  return _buildTheme(_getColorScheme(Brightness.light));
}

ThemeData _buildTheme(ColorScheme colorScheme) {
  final textTheme = TextTheme(
    /// starter headline
    headlineLarge: TextStyle(
      fontSize: 30.sp,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.tertiary,
    ),
    headlineMedium: TextStyle(
      fontSize: 19.sp,
      fontWeight: AppFontWeight.bold,
      color: AppColor.creme,
    ),
    headlineSmall: TextStyle(
      fontSize: 15.sp,
      fontWeight: AppFontWeight.medium,
      color: AppColor.darkYellow,
    ),
    labelLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: AppFontWeight.medium,
      color: colorScheme.onPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: AppFontWeight.bold,
      color: AppColor.creme,
    ),
    labelSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: AppFontWeight.medium,
      color: colorScheme.tertiary,
    ),

    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: AppFontWeight.medium,
      color: colorScheme.tertiary,
    ),
    bodySmall: TextStyle(
      fontSize: 11.sp,
      fontWeight: AppFontWeight.medium,
      color: colorScheme.tertiary,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: AppFont.poppins,
    primaryColor: colorScheme.primary,
    scaffoldBackgroundColor: colorScheme.surface,
    colorScheme: colorScheme,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      centerTitle: true,
      color: colorScheme.primary,
      elevation: 0,
      titleTextStyle: textTheme.headlineMedium,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.tertiary,
      selectedLabelStyle: textTheme.labelSmall,
      unselectedLabelStyle: textTheme.labelSmall,
    ),
    cardTheme: CardTheme(
      color: colorScheme.surface,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConst.kBorderRadius),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColor.lightGrey,
      thickness: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.surface,
        minimumSize: const Size.fromHeight(38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConst.kBorderRadius * 2),
        ),
        textStyle: textTheme.labelMedium,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.darkBrown,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.kBorderRadius),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: AppFontWeight.medium,
        color: AppColor.creme,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.secondary,
      contentTextStyle: textTheme.labelMedium,
      actionTextColor: colorScheme.onPrimary,
    ),
  );
}

ColorScheme _getColorScheme(Brightness brightness) {
  return const ColorScheme.light(
    primary: AppColor.lightYellow,
    secondary: AppColor.darkGreen,
    tertiary: AppColor.darkBrown,
    error: AppColor.error,
    onSurface: AppColor.creme,
    onPrimary: AppColor.creme,
  );
}
