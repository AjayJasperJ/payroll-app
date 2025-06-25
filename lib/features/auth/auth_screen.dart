import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/auth/auth_widget.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: displaysize.height * .3),
                Txt(
                  'Welcome!',
                  size: AppSizes.displayMedium(context),
                  font: Font.medium,
                ),
                SizedBox(height: displaysize.height * .03),
                Container(
                  width: displaysize.width * .85,
                  height: displaysize.height * .45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      displaysize.width * .04,
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Column(children: [Txt("Login")]),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: AuthWidget.SlidableCurtainWidget(
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  SizedBox(height: displaysize.height * .06),
                  Image.asset(
                    Appimages.applogo,
                    height: displaysize.height * .08,
                  ),
                ],
              ),
              buttonwidget: Container(
                color: Colors.white.withValues(alpha: 0),
                child: Column(
                  children: [
                    Txt(
                      'Explore',
                      size: AppSizes.titleLarge(context),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(height: displaysize.height * .02),
                    AuthWidget.upDownInfinite(
                      offset: 10,
                      child: Image.asset(
                        Appicons.download,
                        height: displaysize.height * .03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class demoscreen extends StatefulWidget {
  const demoscreen({super.key});

  @override
  State<demoscreen> createState() => _demoscreenState();
}

class _demoscreenState extends State<demoscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Demo Screen")));
  }
}
