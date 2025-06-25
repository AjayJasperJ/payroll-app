import 'package:flutter/material.dart';
import 'package:payroll_hr/core/constants/colors.dart';

late Size displaysize;
late ColorScheme cs;

payroll_light() {
  return ThemeData(
    fontFamily: 'general_sans',
    colorScheme: ColorScheme.light(
      surface: AppColors.background,
      onSurface: Colors.black,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.container,
      onPrimaryContainer: Colors.black,
      secondary: AppColors.container,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
  );
} //ok

ThemeData payroll_dark() {
  return ThemeData(
    fontFamily: 'general_sans',
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      onSurface: Colors.white,
      primaryContainer: AppColors.container,
      onPrimaryContainer: Colors.black,
      secondary: AppColors.container,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
  );
}
