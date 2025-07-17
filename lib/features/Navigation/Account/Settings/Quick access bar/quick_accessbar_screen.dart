import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/other_widgets.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class QuickbarScreen extends StatefulWidget {
  const QuickbarScreen({super.key});

  @override
  State<QuickbarScreen> createState() => _QuickbarScreenState();
}

class _QuickbarScreenState extends State<QuickbarScreen> {
  final List<Map<String, dynamic>> all_quick_access = [
    {'icon': Appicons.bell, 'title': 'Notification', 'target': ''},
    {'icon': Appicons.calender, 'title': 'Attendance', 'target': ''},
    {'icon': Appicons.home, 'title': 'Applications', 'target': ''},
    {'icon': Appicons.wealth, 'title': 'Payrolls', 'target': ''},
  ];
  List<Map<String, dynamic>> selected_quick_access = [];

  void add_to_selected(int index) {
    setState(() {
      if (!(selected_quick_access.contains(all_quick_access[index]))) {
        selected_quick_access.add(all_quick_access[index]);
      }
    });
  }

  void delete_selected(int index) {
    setState(() {
      selected_quick_access.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height_main * .02, horizontal: height_main * .01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                txtfieldicon(context, Appicons.leftArrow, color: Colors.black),
                Txt('Quick Access Bar', size: AppSizes.titleLarge(context), font: Font.regular),
              ],
            ),
            Container(
              height: height_main * .4,
              width: width_main,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.black),
              ),
              child: ListConfig(
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final item = selected_quick_access.removeAt(oldIndex);
                      selected_quick_access.insert(newIndex, item);
                    });
                    print(selected_quick_access);
                  },
                  buildDefaultDragHandles: false,
                  children: List.generate(selected_quick_access.length, (index) {
                    return Container(
                      key: ValueKey(selected_quick_access[index]['title']),
                      child: ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ReorderableDragStartListener(
                              index: index,
                              child: txtfieldicon(context, Appicons.dragger, color: Colors.black),
                            ),
                            SizedBox(width: 8),
                            txtfieldicon(
                              context,
                              selected_quick_access[index]['icon'],
                              color: Colors.black,
                            ),
                          ],
                        ),
                        title: Txt(selected_quick_access[index]['title']),
                        trailing: GestureDetector(
                          onTap: () => delete_selected(index),
                          child: Container(
                            height: height_main * .04,
                            width: width_main * .1,
                            child: Center(
                              child: txtfieldicon(context, Appicons.delete, color: Colors.red),
                            ),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            Container(
              height: height_main * .38,
              width: width_main,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.black),
              ),
              child: ListConfig(
                child: ListView.builder(
                  itemCount: all_quick_access.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: txtfieldicon(
                        context,
                        all_quick_access[index]['icon'],
                        color: Colors.black,
                      ),
                      title: Txt(all_quick_access[index]['title']),
                      trailing: GestureDetector(
                        onTap: () => add_to_selected(index),
                        child: Container(
                          height: height_main * .04,
                          width: width_main * .2,
                          child: Center(
                            child: Txt(
                              'Add',
                              size: AppSizes.titleSmall(context),
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
