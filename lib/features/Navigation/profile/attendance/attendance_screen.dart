import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/custom_dropdown.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late String _selectedMonth = months[DateTime.now().month - 1];
  late int _selectedYear = DateTime.now().year;
  late List<String> _years = List.generate(10, (i) => (DateTime.now().year - 5 + i).toString());
  int? _selectedDay = DateTime.now().day;
  int? _selectedDayMonth = DateTime.now().month;
  int? _selectedDayYear = DateTime.now().year;

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
          SizedBox(height: height_main * .03),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width_main * .02,
              vertical: height_main * .01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Month selector
                    CustomDropdown(
                      items: months,
                      buttonBorderRadius: displaysize.height / 2,
                      textsize: 15,
                      dropdownBorderRadius: 15,
                      buttonHeight: height_main * .05,
                      buttonWidth: width_main * .35,
                      dropdownHeight: 250,
                      borderColor: Colors.black,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      defaultValue: _selectedMonth.toString(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMonth = value;
                        });
                      },
                    ),
                    // Year selector
                    CustomDropdown(
                      items: _years,
                      buttonBorderRadius: displaysize.height / 2,
                      dropdownBorderRadius: 15,
                      buttonHeight: height_main * .05,
                      buttonWidth: width_main * .3,
                      dropdownHeight: 250,
                      borderColor: Colors.black,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      defaultValue: _selectedYear.toString(),
                      onChanged: (value) {
                        setState(() {
                          _selectedYear = int.parse(value);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Calendar grid
                _buildCalendar(),
              ],
            ),
          ),
          SizedBox(height: height_main * .02),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Txt(
                          '${months[_selectedDayMonth! - 2]} $_selectedDay $_selectedDayYear',
                          color: Colors.white,
                        ),
                        Container(
                          color: Colors.lightGreen,
                          height: height_main * .06,
                          width: width_main * .35,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final int monthIndex = months.indexOf(_selectedMonth) + 1;
    final int year = _selectedYear;
    final int daysInMonth = DateTime(year, monthIndex, 0).day;
    final int firstWeekday = DateTime(year, monthIndex, 1).weekday;
    const List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    List<Widget> dayWidgets = [];
    int dayCounter = 1;
    for (int week = 0; week < 6; week++) {
      List<Widget> weekRow = [];
      for (int wd = 1; wd <= 7; wd++) {
        int weekdayIndex = wd - 1;
        int cellIndex = week * 7 + wd;
        int dateForCell = cellIndex - ((firstWeekday == 7) ? 0 : firstWeekday) + 1;
        if (dateForCell < 1 || dateForCell > daysInMonth) {
          weekRow.add(Expanded(child: SizedBox(height: 0)));
        } else {
          final String weekName = weekdays[weekdayIndex];
          final bool isToday =
              (year == DateTime.now().year &&
              monthIndex == DateTime.now().month &&
              dateForCell == DateTime.now().day);
          weekRow.add(
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = dateForCell;
                    _selectedDayMonth = monthIndex;
                    _selectedDayYear = year;
                  });
                  print('Selected: $dateForCell $_selectedMonth $_selectedYear');
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        width: width_main * .08,
                        decoration: BoxDecoration(
                          color: isToday
                              ? Theme.of(context).colorScheme.primaryContainer
                              : (_selectedDay == dateForCell &&
                                        _selectedDayMonth == monthIndex &&
                                        _selectedDayYear == year
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsetsDirectional.symmetric(vertical: height_main * .006),
                        child: Column(
                          children: [
                            Text(
                              dateForCell.toString(),
                              style: TextStyle(
                                fontSize: AppSizes.bodyLarge(context),
                                fontWeight: FontWeight.bold,
                                color: isToday
                                    ? Colors.black
                                    : (_selectedDay == dateForCell &&
                                              _selectedDayMonth == monthIndex &&
                                              _selectedDayYear == year
                                          ? Colors.white
                                          : Colors.black),
                              ),
                            ),
                            Text(
                              weekName,
                              style: TextStyle(
                                fontSize: AppSizes.labelSmall(context),
                                color: isToday
                                    ? Colors.black
                                    : (_selectedDay == dateForCell &&
                                              _selectedDayMonth == monthIndex &&
                                              _selectedDayYear == year
                                          ? Colors.white
                                          : Colors.black),
                                fontWeight: Font.light.weight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }
      dayWidgets.add(Row(children: weekRow));
      dayWidgets.add(SizedBox(height: 8));
    }
    return Column(children: dayWidgets);
  }
}
