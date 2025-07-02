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
import 'package:payroll_hr/features/Auth/other/otp_screen.dart';
import 'package:payroll_hr/features/Auth/other/reset_screen.dart';
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
  final Rx<Widget> _containerContent = Rx<Widget>(const SizedBox.shrink());
  final Duration _fadeDuration = const Duration(milliseconds: 400);

  void _onCurtainFullyExpanded() {
    _hideStackContent.value = true;
    Future.delayed(const Duration(milliseconds: 0), () {
      if (mounted) {
        _showDemoScreen.value = true;
      }
    });
  }

  void _showWithFade(Widget newChild) async {
    _containerContent.value = AnimatedSwitcher(
      duration: _fadeDuration,
      child: SizedBox.shrink(key: UniqueKey()),
    );
    await Future.delayed(_fadeDuration);
    _containerContent.value = AnimatedSwitcher(duration: _fadeDuration, child: newChild);
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
    // Initial content is LoginScreen
    _containerContent.value = _buildLoginScreen();
  }

  Widget _buildLoginScreen() {
    return LoginScreen(
      forgotpassword: _forgotpassword,
      onForgotPassword: () {
        _showWithFade(_buildOtpScreen());
      },
    );
  }

  Widget _buildOtpScreen() {
    return OtpScreen(
      onSwipe: () {
        _showWithFade(_buildResetScreen());
      },
    );
  }

  Widget _buildResetScreen() {
    return ResetScreen(
      onSubmit: () {
        // You can add logic here for after reset
        _showWithFade(_buildLoginScreen());
      },
    );
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
                              height: _forgotpassword.value
                                  ? constraints.maxHeight * .45
                                  : constraints.maxHeight * .5,
                              width: constraints.maxWidth * .82,
                              padding: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * .01,
                                horizontal: constraints.maxWidth * .03,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.container,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Obx(
                                () => AnimatedSwitcher(
                                  duration: _fadeDuration,
                                  child: _containerContent.value,
                                ),
                              ),
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
