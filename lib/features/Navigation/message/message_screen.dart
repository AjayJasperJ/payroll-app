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
        Padding(
          padding: EdgeInsets.only(left: width_main * .05),
          child: Txt(
            'Messages',
            font: Font.regular,
            size: displaysize.height * .024,
          ),
        ),
        Container(
          width: width_main * .9,
          height: height_main * .88,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(),
                title: Txt("Alex$index"),
                subtitle: Txt(
                  "ghddfioghggj",
                  size: AppSizes.bodySmall(context),
                ),
                trailing: Txt(
                  '01:38',
                  align: TextAlign.end,
                  size: AppSizes.bodySmall(context) - 1,
                  height: 0,
                  space: 0,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
