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
  int selected_index = 0;
  @override
  Widget build(BuildContext context) {
    final user_data = [
      {'username': 'Alex', 'msg': 'Send me copy', 'ltime': '02:39 pm', 'uread': '4'},
      {'username': 'Bheem', 'msg': 'Good Morning', 'ltime': '10:43 am', 'uread': '1'},
      {'username': 'Ali baba', 'msg': 'Mail HR', 'ltime': '09:14 am', 'uread': '0'},
      {'username': 'Nitanshi', 'msg': 'Do you miss me', 'ltime': '12:56 pm', 'uread': '0'},
      {'username': 'Nikhil', 'msg': 'what?me?', 'ltime': '01:35 pm', 'uread': '0'},
    ];
    final category = ['All', 'Unread'];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: height_main * .02),
          Txt('Messages', font: Font.regular, size: displaysize.height * .024),
          SizedBox(height: height_main * .04),
          CustomTxtField(),
          SizedBox(height: height_main * .025),
          Row(
            children: List.generate(category.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selected_index = index;
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(7)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width_main * .03,
                      vertical: height_main * .01,
                    ),
                    child: Txt(category[index]),
                  ),
                  color: selected_index == index
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Colors.transparent,
                ),
              );
            }),
          ),
          SizedBox(height: height_main * .025),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  final value = user_data[index];
                  return CListView(
                    index: index,
                    username: value['username']!,
                    Message: value['msg']!,
                    uread: value['uread']!,
                    Lmsg: value['ltime']!,
                  );
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
  final String username;
  final String Message;
  final String Lmsg;
  final String uread;

  const CListView({
    super.key,
    required this.index,
    required this.username,
    required this.Message,
    required this.Lmsg,
    required this.uread,
  });

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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: displaysize.height * .02, backgroundColor: Colors.grey[300]),
                  SizedBox(width: displaysize.height * .01),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(username, size: AppSizes.titleSmall(context)),
                      SizedBox(height: height_main * .01),
                      Txt(Message, size: AppSizes.labelSmall(context)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height_main * .05,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Txt(Lmsg, size: AppSizes.labelSmall(context) - 2),
                    int.parse(uread) != 0
                        ? CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            radius: 8,
                            child: Txt(
                              uread,
                              size: AppSizes.labelSmall(context) - 2,
                              color: Colors.white,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
