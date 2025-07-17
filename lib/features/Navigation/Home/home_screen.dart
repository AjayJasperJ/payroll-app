//Perfect
import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final weeks = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(
            height: height_main * .35,
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
            height: height_main * .2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.container,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width_main * .04,
              vertical: height_main * .02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(
                      '${DateTime.now().day}, ${months[(DateTime.now().month) - 1]} ${DateTime.now().year}',
                      size: AppSizes.labelLarge(context),
                      font: Font.medium,
                    ),
                    Txt(
                      '${weeks[(DateTime.now().weekday) - 1]}',
                      size: AppSizes.labelLarge(context),
                      font: Font.medium,
                    ),
                    Txt(
                      '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                      size: AppSizes.labelLarge(context),
                      font: Font.medium,
                    ),
                  ],
                ),
                Container(
                  height: height_main * .05,
                  color: Color.fromRGBO(207, 247, 211, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Appicons.verifyPerson, height: height_main * .025),
                      SizedBox(width: width_main * .02),
                      Txt('Punch In', font: Font.medium, size: AppSizes.bodyMedium(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
