import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/auth/auth_widget.dart';
import 'package:payroll_hr/widgets/buttonstyle_widget.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _hideStackContent = false;
  bool _showDemoScreen = false;

  void _onCurtainFullyExpanded() {
    setState(() {
      _hideStackContent = true;
    });
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _showDemoScreen = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          if (!_hideStackContent)
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
                  SizedBox(height: displaysize.height * .05),
                  Container(
                    width: displaysize.width * .85,
                    height: displaysize.height * .45,
                    padding: EdgeInsets.symmetric(
                      horizontal: displaysize.width * .04,
                      vertical: displaysize.height * .04,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        displaysize.width * .06,
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          "Login",
                          size: AppSizes.displaySmall(context),
                          font: Font.medium,
                        ),
                        Column(
                          children: [
                            txtfield(hintText: "Emp ID / Email"),
                            SizedBox(height: displaysize.height * .02),
                            txtfield(hintText: "Password"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: displaysize.height * .055,
                              width: displaysize.width / 2.8,
                              child: ElevatedButton(
                                style: Bstyle.elevated_boardered_apptheme(
                                  context,
                                ),
                                onPressed: () {},
                                child: Txt(
                                  "Forgot Password",
                                  font: Font.medium,
                                  height: 0,
                                  space: 0,
                                  size: AppSizes.bodySmall(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: displaysize.height * .055,
                              width: displaysize.width / 2.8,
                              child: ElevatedButton(
                                style: Bstyle.elevated_filled_apptheme(context),
                                onPressed: () {},
                                child: Txt(
                                  "Login",
                                  font: Font.medium,
                                  space: 1.5,
                                  height: 0,
                                  size: AppSizes.titleMedium(context),
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (!_showDemoScreen)
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
                onFullyExpanded: _onCurtainFullyExpanded,
              ),
            ),
          if (_showDemoScreen) const DemoScreen(),
        ],
      ),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Demo Page")));
  }
}
