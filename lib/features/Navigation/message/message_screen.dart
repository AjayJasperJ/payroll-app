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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: height_main * .02),
          Txt('Messages', font: Font.regular, size: displaysize.height * .024),
          SizedBox(height: height_main * .025),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return CListView(index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CListView extends StatelessWidget {
  final int index;

  const CListView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height_main * .005),
      padding: EdgeInsets.symmetric(vertical: height_main * .015, horizontal: width_main * .02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: displaysize.height * .02, backgroundColor: Colors.grey[100]),
                  SizedBox(width: displaysize.height * .01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt("Username $index", height: 1.5, size: AppSizes.titleSmall(context)),
                      Txt("Latest mesg received", height: 0, size: AppSizes.labelSmall(context)),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Txt('10:38 am', size: AppSizes.labelSmall(context) - 2),
                  SizedBox(height: height_main * .01),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 8,
                    child: Txt(
                      '${index}',
                      size: AppSizes.labelSmall(context) - 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
