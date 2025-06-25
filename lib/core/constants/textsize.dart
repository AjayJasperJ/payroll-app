import 'package:flutter/material.dart';

class TextSizes {
  static double displayLarge(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.09;
  static double displayMedium(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.07;
  static double displaySmall(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.06;

  static double headlineLarge(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.055;
  static double headlineMedium(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.05;
  static double headlineSmall(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.045;

  static double titleLarge(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.04;
  static double titleMedium(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.035;
  static double titleSmall(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.03;

  static double bodyLarge(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.028;
  static double bodyMedium(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.025;
  static double bodySmall(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.022;

  static double labelLarge(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.02;
  static double labelMedium(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.018;
  static double labelSmall(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.016;
}
