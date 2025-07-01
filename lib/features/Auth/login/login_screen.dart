import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/buttonstyle_widget.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class LoginScreen extends StatefulWidget {
  final forgotpassword;

  const LoginScreen({super.key, required this.forgotpassword});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RxBool password_hide = true.obs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Txt('Login', size: AppSizes.displaySmall(context), font: Font.medium, height: .8),
        Column(
          children: [
            txtfield(hintText: "Emp.ID / Email"),
            SizedBox(height: displaysize.height * .02),
            Obx(
              () => txtfield(
                hintText: "Password",
                hidepass: password_hide.value,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        password_hide.value = !password_hide.value;
                      },
                      child: Container(
                        child: Image.asset(
                          Appicons.hide,
                          height: displaysize.height * .025,
                          color: password_hide.value ? Colors.black : theme.colorScheme.primary,
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                    SizedBox(width: displaysize.width * .01),
                  ],
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
    );
  }
}
