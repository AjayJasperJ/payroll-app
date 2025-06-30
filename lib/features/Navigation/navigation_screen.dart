import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/features/Navigation/home/home_screen.dart';
import 'package:payroll_hr/features/Navigation/message/message_screen.dart';
import 'package:payroll_hr/features/Navigation/navigation_widget.dart';
import 'package:payroll_hr/features/Navigation/profile/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> with SingleTickerProviderStateMixin {
  final bottom_fielddata = [
    {'title': 'Home', 'icon': Appicons.home},
    {'title': 'msg', 'icon': Appicons.msg},
    {'title': 'person', 'icon': Appicons.person},
  ];
  int current_index = 0;
  void update_index(int index) {
    setState(() {
      current_index = index;
    });
  }

  // Sidebar animation state
  bool _sidebarExpanded = false;
  late AnimationController _sidebarController;
  late Animation<double> _sidebarWidthAnim;

  @override
  void initState() {
    super.initState();
    _sidebarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _sidebarWidthAnim = Tween<double>(
      begin: displaysize.width * .2 - displaysize.height * .01,
      end: displaysize.width * .65,
    ).animate(CurvedAnimation(parent: _sidebarController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _sidebarController.dispose();
    super.dispose();
  }

  void _toggleSidebar() async {
    if (!_sidebarExpanded) {
      setState(() {
        _sidebarExpanded = true;
      });
      await _sidebarController.forward();
    } else {
      await _sidebarController.reverse();
      setState(() {
        _sidebarExpanded = false;
      });
    }
  }

  final pages = [HomeScreen(), MessageScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    final notificationbar_height = displaysize.height * .04;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // color: AppColors.primary,
          gradient: AppColors.gradentbackground,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            height_main = constraints.maxHeight * .82 - notificationbar_height;
            width_main = constraints.maxWidth * .8;
            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: notificationbar_height),
                    Row(
                      children: [
                        ConstrainedBox(
                          /* Sidebar */
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight * .9 - notificationbar_height,
                            minWidth: constraints.maxWidth * .2,
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                ConstrainedBox(
                                  /* Generate Button */
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight * .08,
                                    minWidth: constraints.maxWidth * .4,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: constraints.maxHeight * .01,
                                      left: constraints.maxHeight * .01,
                                      right: constraints.maxHeight * .005,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  /* Profile Button */
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight * .08,
                                    minWidth: constraints.maxWidth * .4,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: constraints.maxHeight * .01,
                                      right: constraints.maxHeight * .01,
                                      left: constraints.maxHeight * .005,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ConstrainedBox(
                              /* Main Container UI */
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth * .8,
                                minHeight: constraints.maxHeight * .82 - notificationbar_height,
                              ),
                              child: Container(
                                height: height_main - constraints.maxHeight * .02,
                                width: width_main - constraints.maxHeight * .02,
                                padding: EdgeInsets.symmetric(
                                  horizontal: width_main * .030,
                                  vertical: height_main * .015,
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: constraints.maxHeight * .01,
                                  vertical: constraints.maxHeight * .01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: pages[current_index],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight * .1),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: constraints.maxHeight * .01,
                          right: constraints.maxHeight * .01,
                          bottom: constraints.maxHeight * .01,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * .05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            bottom_fielddata.length,
                            (index) => InkWell(
                              child: Card(
                                elevation: 0,
                                color: current_index == index
                                    ? AppColors.inputcolor
                                    : Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: displaysize.height * .04,
                                    height: displaysize.height * .04,
                                    child: Image.asset(
                                      bottom_fielddata[index]['icon']!,
                                      height: displaysize.height * .04,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  current_index = index;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Sidebar overlay and button
                if (_sidebarExpanded)
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _toggleSidebar,
                      child: const SizedBox.expand(),
                    ),
                  ),
                // Sidebar itself
                ConstrainedBox(
                  /* Sidebar */
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight * .9 - notificationbar_height,
                    minWidth: constraints.maxWidth * .2,
                  ),

                  child: NavigationSidebar(
                    width: _sidebarWidthAnim.value,
                    height: constraints.maxHeight * .9 - notificationbar_height,
                    notificationbarHeight: notificationbar_height,
                    onToggle: _toggleSidebar,
                    onIndex: update_index,
                    constraintsh: constraints.maxHeight,
                    sidebarWidthAnim: _sidebarWidthAnim,
                    notificationbar_height: notificationbar_height,
                    icons: [Appicons.bell, Appicons.calender, Appicons.wealth],
                    titles: ['Notification', 'Attendance', 'Payrolls'],
                    selected_index: current_index,
                  ),
                ),
                // Expand/collapse button
              ],
            );
          },
        ),
      ),
    );
  }
}
