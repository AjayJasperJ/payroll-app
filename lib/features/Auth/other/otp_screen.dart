import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/swipetoaction_widget.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class OtpScreen extends StatefulWidget {
  final VoidCallback? onSwipe;
  final VoidCallback? onBack;
  const OtpScreen({super.key, this.onSwipe, this.onBack});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: displaysize.height * .01,
        horizontal: displaysize.width * .01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        key: const ValueKey('forgot'),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.onBack,
                child: Container(
                  color: Colors.transparent,
                  height: displaysize.height * .04,
                  width: displaysize.height * .04,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(Appicons.leftArrow, height: displaysize.height * .02),
                  ),
                ),
              ),
              Txt(
                "OTP Verification",
                height: 0,
                size: AppSizes.headlineSmall(context),
                font: Font.regular,
              ),
            ],
          ),
          Txt("Emp.ID : XXX", size: AppSizes.headlineSmall(context), font: Font.regular),
          Column(
            children: [
              txtotpfield(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                fontSize: AppSizes.bodyMedium(context),
                                fontWeight: Font.medium.weight,
                              ),
                            ),
                            TextSpan(
                              text: "Resend",
                              style: TextStyle(
                                fontSize: AppSizes.bodyMedium(context),
                                fontWeight: Font.bold.weight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: displaysize.width * .02),
                      txtfieldicon(context, Appicons.reload, color: Colors.black),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(),
          Center(
            child: SwipeToActionWidget(
              onSwipe: widget.onSwipe ?? () {},
              label1: 'Swipe to Confirm',
              label2: 'Verified',
              width: displaysize.width * .55,
              height: displaysize.height * .06,
              backgroundColor: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
