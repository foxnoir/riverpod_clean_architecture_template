import 'package:book_lover/core/theme/consts.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return _buildTheme(_getColorScheme(Brightness.light));
}

ThemeData _buildTheme(ColorScheme colorScheme) {
  final textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: AppFontSize.s21,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.onSurface,
    ),
    headlineMedium: const TextStyle(
      fontSize: AppFontSize.s19,
      fontWeight: AppFontWeight.bold,
      color: AppColor.grey,
    ),
    headlineSmall: TextStyle(
      fontSize: AppFontSize.s19,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.onPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: AppFontSize.s12,
      fontWeight: AppFontWeight.medium,
      color: colorScheme.tertiary,
    ),
    labelMedium: TextStyle(
      fontSize: AppFontSize.s16,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.onPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: AppFontSize.s14,
      fontWeight: AppFontWeight.medium,
      color: colorScheme.tertiary,
    ),
    bodySmall: TextStyle(
      fontSize: AppFontSize.s11,
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
      titleTextStyle: textTheme.headlineSmall,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.tertiary,
      selectedLabelStyle: textTheme.labelSmall,
      unselectedLabelStyle: textTheme.labelSmall,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColor.lightGrey,
      thickness: 1,
    ),
    cardTheme: CardTheme(
      color: colorScheme.surface,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.surface,
        minimumSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: textTheme.labelMedium,
      ),
    ),
  );
}

ColorScheme _getColorScheme(Brightness brightness) {
  return const ColorScheme.light(
    primary: AppColor.darkRose,
    secondary: AppColor.darkGreen,
    tertiary: AppColor.darkGrey,
    error: AppColor.error,
    onSurface: AppColor.grey,
  );
}
