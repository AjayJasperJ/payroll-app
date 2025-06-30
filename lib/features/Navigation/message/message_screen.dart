import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Txt('Messages', font: Font.regular, size: displaysize.height * .024),
        Container(
          height: height_main * .88,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return CListView(index: index);
            },
          ),
        ),
      ],
    );
  }
}

class CListView extends StatelessWidget {
  final int index;

  const CListView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: displaysize.height * .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(radius: displaysize.height * .02),
                SizedBox(width: displaysize.height * .01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt("Username $index", size: AppSizes.titleMedium(context)),
                    Txt("Latest mesg received", size: AppSizes.labelMedium(context)),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Txt('10:38', size: AppSizes.labelSmall(context)),
                SizedBox(width: displaysize.height * .01),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
