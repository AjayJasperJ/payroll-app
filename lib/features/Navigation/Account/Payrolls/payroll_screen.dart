//Perfect
import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/custom_dropdown.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  int _selectedYear = DateTime.now().year;
  final List<String> _years = List.generate(10, (i) => (DateTime.now().year - 5 + i).toString());
  String _periodType = 'Monthly';
  final List<String> _periodTypes = ['Monthly', 'Yearly'];

  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  double _scrollMax = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _scrollOffset = _scrollController.offset;
          _scrollMax = _scrollController.position.hasContentDimensions
              ? _scrollController.position.maxScrollExtent
              : 1.0;
        });
      }
    });
    _scrollController.addListener(() {
      if (!mounted) return;
      setState(() {
        _scrollOffset = _scrollController.offset;
        _scrollMax = _scrollController.position.hasContentDimensions
            ? _scrollController.position.maxScrollExtent
            : 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height_main * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              ),

              CustomDropdown(
                items: _periodTypes,
                buttonBorderRadius: displaysize.height / 2,
                dropdownBorderRadius: 15,
                buttonHeight: height_main * .05,
                buttonWidth: width_main * .35,
                dropdownHeight: 250,
                borderColor: Colors.black,
                selectedColor: Theme.of(context).colorScheme.primary,
                defaultValue: _periodType,
              ),
            ],
          ),
          SizedBox(height: height_main * .02),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: months.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: height_main * .09,
                            margin: index != months.length - 1
                                ? EdgeInsets.only(bottom: height_main * .01)
                                : null,
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
                SizedBox(width: width_main * .04),
                Container(
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(displaysize.height),
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double trackHeight = constraints.maxHeight;
                      final double thumbHeight = (trackHeight / months.length).clamp(
                        40,
                        trackHeight,
                      );
                      final double maxScrollExtent =
                          _scrollController.hasClients &&
                              _scrollController.position.hasContentDimensions
                          ? _scrollController.position.maxScrollExtent
                          : 1.0;
                      final double scrollOffset =
                          _scrollController.hasClients &&
                              _scrollController.position.hasContentDimensions
                          ? _scrollController.offset
                          : 0.0;
                      final double thumbTop = maxScrollExtent > 0
                          ? (scrollOffset / maxScrollExtent) * (trackHeight - thumbHeight)
                          : 0.0;
                      return Stack(
                        children: [
                          Positioned(
                            top: thumbTop,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onVerticalDragUpdate: (details) {
                                if (_scrollController.hasClients) {
                                  final double newOffset =
                                      (scrollOffset +
                                              details.delta.dy *
                                                  (maxScrollExtent / (trackHeight - thumbHeight)))
                                          .clamp(0.0, maxScrollExtent);
                                  _scrollController.jumpTo(newOffset);
                                }
                              },
                              child: Container(
                                height: thumbHeight - 4,
                                margin: EdgeInsetsDirectional.symmetric(horizontal: 2, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4),
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
