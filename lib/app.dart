import 'package:flutter/material.dart';
import 'package:payroll_hr/core/constants/colors.dart';

late Size displaysize;

payroll_light() {
  return ThemeData(
    cardColor: AppColors.inputcolor,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      onSurface: Colors.black,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.container,
      onPrimaryContainer: Colors.black,
      secondary: AppColors.inputcolor,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
  );
} //ok

ThemeData payroll_dark() {
  return ThemeData(
    cardColor: AppColors.inputcolor,
    fontFamily: 'Roboto',
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

late double height_main;
late double width_main;
