//Perfect
import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/Navigation/Account/Applications/application_screen.dart';
import 'package:payroll_hr/features/Navigation/Account/Attendance/attendance_screen.dart';
import 'package:payroll_hr/features/Navigation/Account/Employee%20%20self%20service/employee_selfservice_screen.dart';
import 'package:payroll_hr/features/Navigation/Account/Payrolls/payroll_screen.dart';
import 'package:payroll_hr/features/Navigation/Account/settings/settings_screen.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final profile_fielddata = [
    {'title': 'Applications', 'target': ApplicationScreen()},
    {'title': 'Payrolls', 'target': PayrollScreen()},
    {'title': 'Attendance', 'target': AttendanceScreen()},
    {'title': 'Employee Self Services', 'target': EmployeeSelfserviceScreen()},
    {'title': 'Settings', 'target': SettingsScreen()},
  ];
  final user_data = [
    'Name : JordanX',
    'Emp.ID : XXX',
    'Email : jorxxx@gm.com',
    'Profile : Developer',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height_main * .25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width_main * .02,
              vertical: height_main * .02,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width_main * .6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(4, (index) {
                      return Txt(
                        user_data[index],
                        size: AppSizes.titleMedium(context),
                        font: Font.light,
                        height: 0,
                        max: 1,
                      );
                    }),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(Appimages.profile),
                  radius: width_main * .12,
                ),
              ],
            ),
          ),
          Column(
            children: List.generate(profile_fielddata.length, (index) {
              final field = profile_fielddata[index];
              return Container(
                height: height_main * .09,
                margin: EdgeInsets.only(top: height_main * .01),
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
