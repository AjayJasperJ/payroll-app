import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/features/Navigation/navigation_screen.dart';
import 'package:payroll_hr/widgets/buttonstyle_widget.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class LoginScreen extends StatefulWidget {
  final RxBool forgotpassword;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onBack;
  const LoginScreen({super.key, required this.forgotpassword, this.onForgotPassword, this.onBack});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RxBool password_hide = true.obs;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Txt('Login', size: AppSizes.displaySmall(context), font: Font.medium),
        ),
        Column(
          children: [
            txtfield(hintText: "Emp.ID / Email", controller: _emailController),
            SizedBox(height: displaysize.height * .02),
            Obx(
              () => txtfield(
                hintText: "Password",
                hidepass: password_hide.value,
                controller: _passwordController,
                suffixIcon: InkWell(
                  onTap: () {
                    password_hide.value = !password_hide.value;
                  },
                  child: Container(
                    height: displaysize.height * .025,
                    width: displaysize.height * .025,
                    child: Center(
                      child: Image.asset(
                        Appicons.hide,
                        height: displaysize.height * .025,
                        color: password_hide.value ? Colors.black : theme.colorScheme.primary,
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(displaysize.width * .03),
              child: InkWell(
                borderRadius: BorderRadius.circular(displaysize.width * .03),
                hoverColor: theme.colorScheme.secondary.withOpacity(0.2),
                splashColor: theme.colorScheme.secondary.withOpacity(0.3),
                onTap: widget.onForgotPassword,
                child: Container(
                  height: displaysize.height * .055,
                  width: displaysize.width * .35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(displaysize.width * .03),
                    border: Border.all(color: Colors.black, width: .5),
                  ),
                  child: Center(
                    child: Txt(
                      "Forgot Password",
                      font: Font.medium,
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
              width: displaysize.width * .35,
              child: ElevatedButton(
                style: Bstyle.elevated_filled_apptheme(context),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(opacity: animation, child: NavigationScreen());
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return Stack(
                          children: [
                            FadeTransition(
                              opacity: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
                              child: Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Container(color: Colors.transparent),
                              ),
                            ),
                            FadeTransition(opacity: animation, child: child),
                          ],
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                child: Txt(
                  "Login",
                  font: Font.medium,
                  size: AppSizes.titleMedium(context),
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
