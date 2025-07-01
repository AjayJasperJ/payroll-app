import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/Auth/auth_widget.dart';
import 'package:payroll_hr/features/Navigation/navigation_screen.dart';
import 'package:payroll_hr/widgets/buttonstyle_widget.dart';
import 'package:payroll_hr/widgets/swipetoaction_widget.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  final RxBool _hideStackContent = false.obs;
  final RxBool _showDemoScreen = false.obs;
  final RxBool _forgotpassword = false.obs;
  final RxBool _newpassword = false.obs;
  final RxBool _newPasswordFadeIn = false.obs;

  void _onCurtainFullyExpanded() {
    _hideStackContent.value = true;
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        _showDemoScreen.value = true;
      }
    });
  }

  @override
  void didUpdateWidget(covariant AuthScreen oldWidget) {
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
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Obx(
                () => !_hideStackContent.value
                    ? Center(
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
                              height: _newpassword.value
                                  ? displaysize.height * .5
                                  : displaysize.height * .45,
                              padding: EdgeInsets.symmetric(
                                horizontal: displaysize.width * .05,
                                vertical: displaysize.height * .02,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(displaysize.width * .06),
                                color: Theme.of(context).colorScheme.primaryContainer,
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(seconds: 1),
                                /* Set New Password Fade In  */
                                child: _forgotpassword.value
                                    ? Obx(
                                        () => _newpassword.value
                                            ? AnimatedOpacity(
                                                key: const ValueKey('newpassword'),
                                                opacity: _newPasswordFadeIn.value ? 1.0 : 0.0,
                                                duration: const Duration(seconds: 1),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            _newpassword.value = false;
                                                          },
                                                          child: Container(
                                                            color: Colors.transparent,
                                                            height: displaysize.height * .04,
                                                            width: displaysize.height * .04,
                                                            child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Image.asset(
                                                                Appicons.leftArrow,
                                                                height: displaysize.height * .02,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Txt(
                                                          "Reset Password",
                                                          height: 0,
                                                          size: AppSizes.headlineMedium(context),
                                                          font: Font.regular,
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: List.generate(3, (index) {
                                                        List field_data = [
                                                          {'title': 'Emp.ID : XXX'},
                                                          {'title': 'Email ID : XXX@x.com'},
                                                          {'title': 'Phone No : XXXXXXXXXX'},
                                                        ];
                                                        return Txt(
                                                          field_data[index]['title'],
                                                          size: AppSizes.titleLarge(context),
                                                        );
                                                      }),
                                                    ),
                                                    txtfield(hintText: "New Password"),
                                                    Center(
                                                      child: SizedBox(
                                                        height: displaysize.height * .055,
                                                        child: ElevatedButton(
                                                          style: Bstyle.elevated_filled_apptheme(
                                                            context,
                                                          ),
                                                          onPressed: () {
                                                            _forgotpassword.value = false;
                                                            _newpassword.value = false;
                                                          },
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: displaysize.width * .04,
                                                            ),
                                                            child: Txt(
                                                              "Submit",
                                                              font: Font.bold,
                                                              size: AppSizes.titleLarge(context),
                                                              color: theme.colorScheme.onPrimary,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            /* If not new password, show OTP verification */
                                            : Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                key: const ValueKey('forgot'),
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          _forgotpassword.value = false;
                                                        },
                                                        child: Container(
                                                          color: Colors.transparent,
                                                          height: displaysize.height * .04,
                                                          width: displaysize.height * .04,
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Image.asset(
                                                              Appicons.leftArrow,
                                                              height: displaysize.height * .02,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Txt(
                                                        "OTP Verification",
                                                        height: 0,
                                                        size: AppSizes.headlineMedium(context),
                                                        font: Font.regular,
                                                      ),
                                                    ],
                                                  ),
                                                  Txt(
                                                    "Emp.ID : XXX",
                                                    size: AppSizes.headlineSmall(context),
                                                    font: Font.regular,
                                                  ),
                                                  Column(
                                                    children: [
                                                      txtotpfield(),
                                                      SizedBox(height: displaysize.height * .01),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Txt(
                                                            '05:00',
                                                            size: AppSizes.bodyMedium(context),
                                                            color: theme.colorScheme.primary,
                                                            font: Font.medium,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: "Didn't got OTP ? ",
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            AppSizes.bodyMedium(
                                                                              context,
                                                                            ),
                                                                        fontWeight:
                                                                            Font.medium.weight,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: "Resend",
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            AppSizes.bodyMedium(
                                                                              context,
                                                                            ),
                                                                        fontWeight:
                                                                            Font.bold.weight,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: displaysize.width * .02,
                                                              ),
                                                              txtfieldicon(
                                                                context,
                                                                Appicons.reload,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Center(
                                                    child: SwipeToActionWidget(
                                                      onSwipe: () {
                                                        _newpassword.value = true;
                                                      },
                                                      label1: 'Swipe to Confirm',
                                                      label2: 'Verified',
                                                      width: displaysize.width * .55,
                                                      height: displaysize.height * .06,
                                                      backgroundColor: theme.colorScheme.primary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      )
                                    /* If not new password, show login form */
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: displaysize.height * .02,
                                        ),
                                        child: Column(
                                          key: const ValueKey('login'),
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Txt(
                                              "Login",
                                              size: AppSizes.displaySmall(context),
                                              font: Font.medium,
                                              height: .8,
                                            ),
                                            Column(
                                              children: [
                                                txtfield(hintText: "Emp.ID / Email"),
                                                SizedBox(height: displaysize.height * .02),
                                                txtfield(hintText: "Password"),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  borderRadius: BorderRadius.circular(
                                                    displaysize.width * .03,
                                                  ),
                                                  child: InkWell(
                                                    borderRadius: BorderRadius.circular(
                                                      displaysize.width * .03,
                                                    ),
                                                    hoverColor: theme.colorScheme.secondary
                                                        .withOpacity(0.2),
                                                    splashColor: theme.colorScheme.secondary
                                                        .withOpacity(0.3),
                                                    onTap: () {
                                                      _forgotpassword.value = true;
                                                    },
                                                    child: Container(
                                                      height: displaysize.height * .055,
                                                      width: displaysize.width / 2.9,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(
                                                          displaysize.width * .03,
                                                        ),
                                                        border: Border.all(color: Colors.black),
                                                      ),
                                                      child: Center(
                                                        child: Txt(
                                                          "Forgot Password",
                                                          font: Font.bold,
                                                          height: 3,
                                                          space: 0,
                                                          size: AppSizes.bodyMedium(context),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: displaysize.height * .055,
                                                  width: displaysize.width / 2.9,
                                                  child: ElevatedButton(
                                                    style: Bstyle.elevated_filled_apptheme(context),
                                                    onPressed: () {},
                                                    child: Txt(
                                                      "Login",
                                                      font: Font.bold,
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
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              /* Animated slider Stack */
              Obx(
                () => !_showDemoScreen.value
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: AuthWidget.SlidableCurtainWidget(
                          color: Theme.of(context).colorScheme.primary,
                          child: Column(
                            children: [
                              SizedBox(height: displaysize.height * .06),
                              Image.asset(Appimages.applogo, height: displaysize.height * .08),
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
                      )
                    : SizedBox.shrink(),
              ),
              Obx(() => _showDemoScreen.value ? NavigationScreen() : SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
