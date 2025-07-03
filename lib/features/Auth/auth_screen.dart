import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/Auth/auth_widget.dart';
import 'package:payroll_hr/features/Auth/Login/login_screen.dart';
import 'package:payroll_hr/features/Auth/Other/otp_screen.dart';
import 'package:payroll_hr/features/Auth/Other/reset_screen.dart';
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
  final Duration _fadeDuration = const Duration(milliseconds: 400);

  // Custom stack for auth screens
  final List<String> _authStack = ['login'];

  void _pushAuth(String screen) {
    setState(() {
      _authStack.add(screen);
    });
  }

  void _popAuth() {
    setState(() {
      if (_authStack.length > 1) {
        _authStack.removeLast();
      }
    });
  }

  Widget _getAuthScreen() {
    final String current = _authStack.last;
    switch (current) {
      case 'otp':
        return OtpScreen(onSwipe: () => _pushAuth('reset'), onBack: _popAuth);
      case 'reset':
        return ResetScreen(onSubmit: () => _pushAuth('login'), onBack: _popAuth);
      case 'login':
      default:
        return LoginScreen(
          forgotpassword: _forgotpassword,
          onForgotPassword: () => _pushAuth('otp'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_authStack.length > 1) {
          _popAuth();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: displaysize.height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: Obx(
                        () => !_showDemoScreen.value
                            ? Column(
                                children: [
                                  SizedBox(height: constraints.maxHeight * .33),
                                  Txt(
                                    "Welcome!",
                                    size: AppSizes.displayMedium(context),
                                    font: Font.medium,
                                  ),
                                  SizedBox(height: constraints.maxHeight * .04),
                                  Container(
                                    height: _authStack.last == 'reset'
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
                                    child: AnimatedSwitcher(
                                      duration: _fadeDuration,
                                      child: _getAuthScreen(),
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
                    onFullyExpanded: () {
                      _hideStackContent.value = true;
                      Future.delayed(const Duration(milliseconds: 0), () {
                        if (mounted) {
                          _showDemoScreen.value = true;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
