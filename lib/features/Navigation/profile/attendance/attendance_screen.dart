import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  late String _selectedMonth = months[DateTime.now().month - 1];
  late int _selectedYear = DateTime.now().year;
  late List<int> _years = List.generate(10, (i) => DateTime.now().year - 5 + i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height_main * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              txtfieldicon(context, Appicons.leftArrow, color: Colors.black),
              Txt('Attendence', size: AppSizes.titleLarge(context), font: Font.regular),
            ],
          ),
          SizedBox(height: height_main * .02),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(15),
              side: BorderSide(color: Colors.black),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Month selector
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: _showMonthPicker,
                        child: Text(_selectedMonth),
                      ),
                      // Year selector
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: _showYearPicker,
                        child: Text(_selectedYear.toString()),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Calendar grid
                  _buildCalendar(),
                ],
              ),
            ),
          ),
          SizedBox(height: height_main * .02),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMonthPicker() async {
    String? selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...months.map(
                  (month) =>
                      ListTile(title: Text(month), onTap: () => Navigator.of(context).pop(month)),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    if (selected != null) {
      setState(() {
        _selectedMonth = selected;
      });
    }
  }

  void _showYearPicker() async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    // Find the year button's RenderBox
    final RenderBox? yearButton =
        button.visitChildren(
              (child) => child is RenderBox && (child).size == button.size ? child : null,
            )
            as RenderBox?;
    final Offset buttonPosition = yearButton != null
        ? yearButton.localToGlobal(Offset.zero, ancestor: overlay)
        : button.localToGlobal(Offset.zero, ancestor: overlay);
    final Size buttonSize = yearButton != null ? yearButton.size : button.size;
    int? selected = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy + buttonSize.height,
        overlay.size.width - (buttonPosition.dx + buttonSize.width),
        overlay.size.height - (buttonPosition.dy + buttonSize.height),
      ),
      items: _years.map((year) {
        return PopupMenuItem<int>(value: year, child: Text(year.toString()));
      }).toList(),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black),
      ),
    );
    if (selected != null) {
      setState(() {
        _selectedYear = selected;
      });
    }
  }

  Widget _buildCalendar() {
    final int monthIndex = months.indexOf(_selectedMonth) + 1;
    final int year = _selectedYear;
    final int daysInMonth = DateTime(year, monthIndex + 1, 0).day;
    final int firstWeekday = DateTime(year, monthIndex, 1).weekday;
    const List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    List<Widget> dayWidgets = [];
    int day = 1;
    for (int week = 0; week < 6; week++) {
      List<Widget> weekRow = [];
      for (int wd = 1; wd <= 7; wd++) {
        int weekdayIndex = wd - 1;
        if ((week == 0 && wd < ((firstWeekday == 7) ? 1 : firstWeekday + 1)) || day > daysInMonth) {
          weekRow.add(Expanded(child: SizedBox(height: 48)));
        } else {
          final String weekName = weekdays[weekdayIndex];
          weekRow.add(
            Expanded(
              child: Column(
                children: [
                  Text(day.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(weekName, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  SizedBox(height: 8),
                ],
              ),
            ),
          );
          day++;
        }
      }
      dayWidgets.add(Row(children: weekRow));
      dayWidgets.add(SizedBox(height: 8));
      if (day > daysInMonth) break;
    }
    return Column(children: dayWidgets);
  }
}
