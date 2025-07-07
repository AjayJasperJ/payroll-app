import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/Navigation/Account/Settings/Notifications/notification_screen.dart';
import 'package:payroll_hr/features/Navigation/Account/Settings/Profile/profile_screen.dart';
import 'package:payroll_hr/features/Navigation/Account/Settings/Quick%20access%20bar/quick_accessbar_screen.dart';
import 'package:payroll_hr/features/Navigation/Account/Settings/Theme/theme_screen.dart';
import 'package:payroll_hr/features/Navigation/navigation_screen.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settings_fielddata = [
    {'title': 'Profile', 'target': ProfileScreen()},
    {'title': 'Notifications', 'target': NotificationScreen()},
    {'title': 'Quick access bar', 'target': QuickbarScreen()},
    {'title': 'Theme', 'target': ThemeScreen()},
    {'title': 'Logout', 'target': ''},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height_main * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              txtfieldicon(context, Appicons.leftArrow, color: Colors.black),
              Txt('Settings', size: AppSizes.titleLarge(context), font: Font.regular),
            ],
          ),
          SizedBox(height: height_main * .03),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(settings_fielddata.length, (index) {
              final field = settings_fielddata[index];
              if (index != settings_fielddata.length - 1)
                return GestureDetector(
                  onTap: () {
                    NavigationScreen.of(context)?.CurrentPageInLayout(targetpage: field['target']);
                  },
                  child: Container(
                    height: height_main * .09,
                    margin: EdgeInsets.only(top: height_main * .015),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width_main * .04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(field['title'].toString(), size: AppSizes.titleMedium(context)),
                        txtfieldicon(context, Appicons.right_arrow, color: Colors.black),
                      ],
                    ),
                  ),
                );
              else
                return Container(
                  height: height_main * .09,
                  margin: EdgeInsets.only(top: height_main * .015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width_main * .04),
                  child: Center(
                    child: Txt(field['title'].toString(), size: AppSizes.titleMedium(context)),
                  ),
                );
            }),
          ),
        ],
      ),
    );
  }
}
