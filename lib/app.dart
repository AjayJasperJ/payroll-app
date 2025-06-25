import 'package:flutter/material.dart';
import 'package:payroll_hr/features/auth/auth_screen.dart';
import 'package:payroll_hr/core/constants/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    displaysize = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Payroll HR',
      themeMode: ThemeMode.light,
      theme: payroll_light(),
      darkTheme: payroll_dark(),
      home: const AuthScreen(),
    );
  }
}

late Size displaysize;

ThemeData payroll_light() {
  return ThemeData(
    fontFamily: 'general_sans',
    colorScheme: ColorScheme.light(
      surface: AppColors.background,
      onSurface: Colors.black,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.container,
      onPrimaryContainer: Colors.black,
    ),
    cardColor: AppColors.container,
  );
}

ThemeData payroll_dark() {
  return ThemeData(
    fontFamily: 'general_sans',
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.container,
      onPrimary: Colors.white,
      onSurface: Colors.white,
      secondary: AppColors.container,
    ),
    scaffoldBackgroundColor: AppColors.background,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.inputcolor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    cardColor: AppColors.container,
  );
}
