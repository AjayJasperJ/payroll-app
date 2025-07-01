import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/Auth/auth_widget.dart';
import 'package:payroll_hr/features/Auth/login/login_screen.dart';
import 'package:payroll_hr/features/Navigation/navigation_screen.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({super.key});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  final RxBool _hideStackContent = false.obs;
  final RxBool _showDemoScreen = false.obs;
  final RxBool _forgotpassword = true.obs;
  final RxBool _newpassword = false.obs;
  final RxBool _newPasswordFadeIn = false.obs;

  void _onCurtainFullyExpanded() {
    _hideStackContent.value = true;
    Future.delayed(const Duration(milliseconds: 0), () {
      if (mounted) {
        _showDemoScreen.value = true;
      }
    });
  }

  @override
  void didUpdateWidget(covariant AuthLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Not needed for this fix
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Not needed for this fix
  }

  @override
  void initState() {
    super.initState();
    ever(_newpassword, (val) {
      if (val == true) {
        _newPasswordFadeIn.value = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _newPasswordFadeIn.value = true;
        });
      } else {
        _newPasswordFadeIn.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Obx(
                  () => !_showDemoScreen.value
                      ? Column(
                          children: [
                            SizedBox(height: constraints.maxHeight * .32),
                            Txt(
                              "Welcome!",
                              size: AppSizes.displayMedium(context),
                              font: Font.medium,
                            ),
                            SizedBox(height: constraints.maxHeight * .04),
                            Container(
                              height: !_forgotpassword.value
                                  ? constraints.maxHeight * .5
                                  : constraints.maxHeight * .45,
                              width: constraints.maxWidth * .82,
                              padding: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * .01,
                                horizontal: constraints.maxWidth * .03,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.container,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: LoginScreen(forgotpassword: _forgotpassword),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: AuthWidget.SlidableCurtainWidget(
              targetPage: NavigationScreen(),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  SizedBox(height: displaysize.height * .06),
                  Image.asset(Appimages.applogo, height: displaysize.height * .08),
                ],
              ),
              buttonwidget: Container(
                height: displaysize.height * .08,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Txt(
                      'Explore',
                      size: AppSizes.titleLarge(context),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(height: displaysize.height * .01),
                    AuthWidget.upDownInfinite(
                      offset: 5,
                      child: Image.asset(Appicons.download, height: displaysize.height * .03),
                    ),
                  ],
                ),
              ),
              onFullyExpanded: _onCurtainFullyExpanded,
            ),
          ),
        ],
      ),
    );
  }
}
