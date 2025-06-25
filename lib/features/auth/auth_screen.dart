import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/auth/auth_widget.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class RectangleCircleBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return AuthWidget.rectanglecirclebottom(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: ClipPath(
          clipper: RectangleCircleBottomClipper(),
          child: Container(
            padding: EdgeInsets.only(top: displaysize.height * .06),
            height: displaysize.height * .4,
            width: displaysize.width,
            color: AppColors.primary,
            child: Column(
              children: [
                Image.asset(
                  Appimages.applogo,
                  height: displaysize.height * .08,
                ),
                Txt(
                  'Explore',
                  align: TextAlign.center,
                  size: AppSizes.headlineMedium(context),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
