import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settings_fielddata = [
    {'title': 'Profile', 'target': ''},
    {'title': 'Notifications', 'target': ''},
    {'title': 'Quick access bar', 'target': ''},
    {'title': 'Theme', 'target': ''},
    {'title': 'Logout', 'target': ''},
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width_main * .9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          SizedBox(
            width: width_main * .9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                txtfieldicon(context, Appicons.leftArrow, color: Colors.black),
                Txt("Settings", size: AppSizes.titleLarge(context)),
              ],
            ),
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(settings_fielddata.length, (index) {
              final field = settings_fielddata[index];
              if (index != settings_fielddata.length - 1)
                return Container(
                  height: height_main * .1,
                  width: width_main * .9,
                  margin: EdgeInsets.only(top: height_main * .015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width_main * .04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(field['title']!, size: AppSizes.titleLarge(context) - 2),
                      txtfieldicon(context, Appicons.right_arrow, color: Colors.black),
                    ],
                  ),
                );
              else
                return Container(
                  height: height_main * .1,
                  width: width_main * .9,
                  margin: EdgeInsets.only(top: height_main * .015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width_main * .04),
                  child: Center(
                    child: Txt(field['title']!, size: AppSizes.titleLarge(context) - 2),
                  ),
                );
            }),
          ),
        ],
      ),
    );
  }
}
