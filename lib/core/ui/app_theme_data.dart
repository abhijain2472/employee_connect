import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static const _fontFamily = 'Roboto';

  static ThemeData lightThemeData(BuildContext context) => ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 57,
            height: 64 / 57,
            letterSpacing: -0.25,
            fontWeight: FontWeight.w400,
          ),
          displayMedium: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 45,
            height: 52 / 45,
            fontWeight: FontWeight.w400,
          ),
          displaySmall: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 36,
            height: 44 / 36,
            fontWeight: FontWeight.w400,
          ),
          headlineLarge: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 32,
            height: 40 / 32,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 28,
            height: 36 / 28,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 24,
            height: 32 / 24,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 22,
            height: 28 / 22,
            fontWeight: FontWeight.w400,
          ),
          titleMedium: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
          titleSmall: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
          labelLarge: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
          labelMedium: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          labelSmall: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 11,
            height: 16 / 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          bodyLarge: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: 0.25,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 12,
            height: 16 / 12,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w400,
          ),
        ),
       dividerColor: AppColors.dividerColor,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 18,
            height: 22 / 18,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      );
}
