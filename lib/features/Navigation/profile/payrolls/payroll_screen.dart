import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  int _selectedYear = DateTime.now().year;
  int _selectedYear2 = DateTime.now().year;
  final List<int> _years = List.generate(10, (i) => DateTime.now().year - 5 + i);
  String _periodType = 'Monthly';
  final List<String> _periodTypes = ['Monthly', 'Yearly'];
  int _selectedMonthIndex = DateTime.now().month - 1;
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  double _scrollMax = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Year 1 selector
              DropdownButton<int>(
                value: _selectedYear2,
                items: _years.map((int year) {
                  return DropdownMenuItem<int>(value: year, child: Text(year.toString()));
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedYear2 = newValue!;
                  });
                },
              ),
              // Period type selector
              DropdownButton<String>(
                value: _periodType,
                items: _periodTypes.map((String type) {
                  return DropdownMenuItem<String>(value: type, child: Text(type));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _periodType = newValue!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: height_main * .01),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification.metrics.axis == Axis.vertical) {
                        setState(() {
                          _scrollOffset = notification.metrics.pixels;
                          _scrollMax = notification.metrics.maxScrollExtent;
                        });
                      }
                      return false;
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: months.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMonthIndex = index;
                            });
                          },
                          child: Container(
                            height: height_main * .1,
                            margin: EdgeInsets.symmetric(vertical: height_main * .01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: width_main * .04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Txt(months[index], size: AppSizes.titleMedium(context)),
                                txtfieldicon(context, Appicons.right_arrow, color: Colors.black),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: width_main * .05),
                Container(
                  height: double.infinity,
                  width: 20,
                  alignment: Alignment.topCenter,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double barHeight = height_main * .08;
                      final double trackHeight = constraints.maxHeight;
                      final double gap = 10.0;
                      final double maxBarTravel = trackHeight - barHeight - gap;
                      final double barTop = (_scrollMax > 0)
                          ? (_scrollOffset / _scrollMax * maxBarTravel).clamp(0.0, maxBarTravel)
                          : 0.0;
                      return Stack(
                        children: [
                          Container(
                            width: 20,
                            height: trackHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                          ),
                          Positioned(
                            top: barTop,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 10,
                                height: barHeight,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 6,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
