import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profile_fielddata = [
    {'title': 'Applications', 'target': ''},
    {'title': 'Payrolls', 'target': ''},
    {'title': 'Attendance', 'target': ''},
    {'title': 'Employee Self Services', 'target': ''},
    {'title': 'Settings', 'target': ''},
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
                    children: [
                      Txt(
                        'Name : JordanX',
                        size: AppSizes.titleMedium(context),
                        font: Font.light,
                        max: 1,
                      ),
                      Txt(
                        'Emp.ID : XXX',
                        size: AppSizes.titleMedium(context),
                        font: Font.light,
                        max: 1,
                      ),
                      Txt(
                        'Email : jorxxx@gm.com',
                        size: AppSizes.titleMedium(context),
                        font: Font.light,
                        max: 1,
                      ),
                      Txt(
                        'Profile : Developer',
                        size: AppSizes.titleMedium(context),
                        font: Font.light,
                        max: 1,
                      ),
                    ],
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
                height: height_main * .1,
                margin: EdgeInsets.only(top: height_main * .01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                padding: EdgeInsets.symmetric(horizontal: width_main * .04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(field['title']!, size: AppSizes.titleMedium(context)),
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
