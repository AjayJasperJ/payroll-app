import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/buttonstyle_widget.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class ResetScreen extends StatefulWidget {
  final VoidCallback? onSubmit;
  final VoidCallback? onBack;
  const ResetScreen({super.key, this.onSubmit, this.onBack});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
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
                "Reset Password",
                height: 0,
                size: AppSizes.headlineSmall(context),
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
              return Txt(field_data[index]['title'], height: 0, size: AppSizes.titleLarge(context));
            }),
          ),
          txtfield(hintText: "New Password"),
          Center(
            child: Dismissible(
              key: const ValueKey('reset_swipe'),
              direction: DismissDirection.up,
              onDismissed: (_) {
                if (widget.onSubmit != null) widget.onSubmit!();
              },
              child: SizedBox(
                height: displaysize.height * .055,
                child: ElevatedButton(
                  style: Bstyle.elevated_filled_apptheme(context),
                  onPressed: widget.onSubmit ?? () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
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
          ),
        ],
      ),
    );
  }
}
