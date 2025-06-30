import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: height_main * .25,
          width: width_main * .9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          padding: EdgeInsets.symmetric(horizontal: width_main * .02, vertical: height_main * .02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width_main * .6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt('Name : JordanX', size: height_main * .025, font: Font.light),
                    Txt('Emp.ID : XXX', size: height_main * .025, font: Font.light),
                    Txt('Email : jorxxx@gm.com', size: height_main * .025, font: Font.light),
                    Txt('Profile : Developer', size: height_main * .025, font: Font.light),
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
              width: width_main * .9,
              margin: EdgeInsets.only(top: height_main * .01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primaryContainer,
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
          }),
        ),
      ],
    );
  }
}
