import 'dart:math';

import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/Navigation/Account/Settings/Profile/profile_widget.dart';
import 'package:payroll_hr/widgets/buttonstyle_widget.dart';
import 'package:payroll_hr/widgets/other_widgets.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool name_exp = false;
  bool phone_exp = false;
  bool address_exp = false;
  String get_name = 'Nitanshi';
  String get_phone = '9883682819';
  String get_address = 'Chennai';
  TextEditingController new_name = TextEditingController();
  TextEditingController new_phone = TextEditingController();
  TextEditingController new_address = TextEditingController();

  void expand(String name) {
    setState(() {
      switch (name) {
        case 'name':
          name_exp = true;
          phone_exp = false;
          address_exp = false;
          break;
        case 'phone':
          phone_exp = true;
          name_exp = false;
          address_exp = false;
          break;
        case 'address':
          address_exp = true;
          name_exp = false;
          phone_exp = false;
          break;
        default:
      }
    });
  }

  void _shrink(String name) {
    setState(() {
      switch (name) {
        case 'name':
          name_exp = !name_exp;
          break;
        case 'phone':
          phone_exp = !phone_exp;
          break;
        case 'address':
          address_exp = !address_exp;
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> field_data = [
      {
        'type': 'name',
        'title': get_name,
        'expanded': name_exp,
        'controller': new_name,
        'validate': '',
      },
      {
        'type': 'phone',
        'title': get_phone,
        'expanded': phone_exp,
        'controller': new_phone,
        'validate': '',
      },
      {
        'type': 'address',
        'title': get_address,
        'expanded': address_exp,
        'controller': new_address,
        'validate': '',
      },
    ];

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final hiddenHeight = max(
      0.0,
      height_main - ((displaysize.height * .1 + height_main) - keyboardHeight),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: hiddenHeight),
        child: Column(
          children: [
            SizedBox(height: height_main * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                txtfieldicon(context, Appicons.leftArrow, color: Colors.black),
                Txt('Profile', size: AppSizes.titleLarge(context), font: Font.regular),
              ],
            ),
            SizedBox(height: height_main * .05),
            CircleAvatar(radius: height_main * .1, backgroundImage: AssetImage(Appimages.profile)),
            SizedBox(height: height_main * .03),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Txt('Update Photo', size: AppSizes.titleLarge(context)),
                SizedBox(width: width_main * .02),
                Image.asset(Appicons.edit, height: height_main * .035),
              ],
            ),
            SizedBox(height: height_main * .05),
            ListConfig(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final field = field_data[index];
                  return Column(
                    children: [
                      ExpandableCard(
                        expanded: field['expanded'],
                        title: field['title'],
                        maxExpandHeight: height_main * .28,
                        normalHeight: height_main * .09,
                        normalWidth: double.infinity,
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width_main * .04),
                          child: Column(
                            children: [
                              txtfield(
                                hintText: 'Enter ${field['type']}',
                                controller: field['controller'],
                              ),
                              SizedBox(height: height_main * .03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _shrink(field['type']);
                                    },
                                    child: Container(
                                      height: height_main * .05,
                                      width: width_main * .3,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Txt(
                                          'Discard',
                                          color: Colors.black,
                                          font: Font.medium,
                                          size: AppSizes.titleMedium(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height_main * .05,
                                    width: width_main * .3,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          switch (field['type']) {
                                            case 'name':
                                              get_name = field['controller'].text;
                                              break;
                                            case 'phone':
                                              get_phone = field['controller'].text;
                                              break;
                                            case 'address':
                                              get_address = field['controller'].text;
                                              break;
                                          }
                                        });
                                        _shrink(field['type']);
                                      },
                                      style: Bstyle.elevated_filled_apptheme(context),
                                      child: Txt(
                                        'Save',
                                        color: Colors.white,
                                        font: Font.medium,
                                        size: AppSizes.titleMedium(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onExpand: () => expand(field['type']),
                        onShrink: () => _shrink(field['type']),
                      ),
                      SizedBox(height: height_main * .015),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
