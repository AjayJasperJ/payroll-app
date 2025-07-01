import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(
            height: height_main * .37,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.container,
            ),
          ),
          Container(
            height: height_main * .37,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.container,
            ),
          ),
          Container(
            height: height_main * .18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.container,
            ),
          ),
        ],
      ),
    );
  }
}
