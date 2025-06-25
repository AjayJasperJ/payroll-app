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
      body: Column(
        children: [
          ClipPath(
            clipper: RectangleCircleBottomClipper(),
            child: Container(
              padding: EdgeInsets.only(top: displaysize.height * .06),
              height: displaysize.height * .35,
              width: displaysize.width,
              color: AppColors.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Appimages.applogo,
                    height: displaysize.height * .08,
                  ),
                  Column(
                    children: [
                      Txt(
                        'Explore',
                        font: Font.medium,
                        align: TextAlign.center,
                        size: AppSizes.headlineMedium(context),
                        color: Colors.white,
                      ),
                      SizedBox(height: displaysize.height * .01),
                      AuthWidget.upDownInfinite(
                        offset: 10,
                        child: Image.asset(
                          Appicons.download,
                          color: Colors.white,
                          height: displaysize.height * .03,
                        ),
                      ),
                      SizedBox(height: displaysize.height * .06),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Txt(
            'Welcome !',
            font: Font.semiBold,
            space: 1.5,
            align: TextAlign.center,
            size: AppSizes.displayMedium(context),
          ),
          Container(
            width: displaysize.width * .85,
            height: displaysize.height * .4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.container,
            ),
          ),
        ],
      ),
    );
  }
}
