import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/colors.dart';
import 'package:payroll_hr/core/constants/images.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with SingleTickerProviderStateMixin {
  final notificationbar_height = displaysize.height * .06;
  final bottom_fielddata = [
    {'title': 'Home', 'icon': Appicons.home},
    {'title': 'msg', 'icon': Appicons.msg},
    {'title': 'person', 'icon': Appicons.person},
  ];
  int current_index = 0;

  // Sidebar animation state
  bool _sidebarExpanded = false;
  late AnimationController _sidebarController;
  late Animation<double> _sidebarWidthAnim;

  static const double sidebarShadowStartWidth = 90;
  static const double sidebarMaxShadow = 20;

  @override
  void initState() {
    super.initState();
    _sidebarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _sidebarWidthAnim =
        Tween<double>(
          begin: displaysize.width * .2 - displaysize.height * .01,
          end: displaysize.width * .8,
        ).animate(
          CurvedAnimation(parent: _sidebarController, curve: Curves.easeInOut),
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.gradentbackground),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: notificationbar_height),
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight * .02,
                            minWidth: constraints.maxWidth * .2,
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                              left: constraints.maxHeight * .01,
                              bottom: constraints.maxHeight * .01,
                              top: constraints.maxHeight * .01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight * .08,
                                    minWidth: constraints.maxWidth * .4,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: constraints.maxHeight * .01,
                                      right: constraints.maxHeight * .005,
                                      top: constraints.maxHeight * .01,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight * .08,
                                    minWidth: constraints.maxWidth * .4,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: constraints.maxHeight * .01,
                                      left: constraints.maxHeight * .005,
                                      right: constraints.maxHeight * .01,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth * .8,
                                minHeight:
                                    constraints.maxHeight * .82 -
                                    notificationbar_height,
                              ),
                              child: Container(
                                margin: EdgeInsets.all(
                                  constraints.maxHeight * .01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight * .1,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: constraints.maxHeight * .01,
                          right: constraints.maxHeight * .01,
                          bottom: constraints.maxHeight * .01,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * .05,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
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
                  constraints: BoxConstraints(
                    minHeight:
                        constraints.maxHeight * .8 - notificationbar_height,
                    minWidth: constraints.maxWidth * .18,
                  ),
                  child: AnimatedBuilder(
                    animation: _sidebarWidthAnim,
                    builder: (context, child) {
                      final double width = _sidebarWidthAnim.value;
                      double shadow = 0;
                      if (width > sidebarShadowStartWidth) {
                        final double t =
                            ((width - sidebarShadowStartWidth) /
                                    (displaysize.width * .8 -
                                        sidebarShadowStartWidth))
                                .clamp(0.0, 1.0);
                        shadow = t * sidebarMaxShadow;
                      }
                      return Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        elevation: 0,
                        child: GestureDetector(
                          onTap: _toggleSidebar,
                          child: Container(
                            height:
                                constraints.maxHeight * .88 -
                                notificationbar_height,
                            width: width,
                            margin: EdgeInsets.only(
                              left: constraints.maxHeight * .01,
                              bottom: constraints.maxHeight * .01,
                              top:
                                  notificationbar_height +
                                  constraints.maxHeight * .01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.deepPurple,
                              boxShadow: shadow > 0
                                  ? [
                                      BoxShadow(
                                        color: Colors.black26.withOpacity(
                                          shadow / sidebarMaxShadow * 0.7,
                                        ),
                                        blurRadius: shadow,
                                        offset: Offset(0, shadow * 0.4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          displaysize.width * .2 -
                                          constraints.maxHeight * .01,
                                      child: Center(
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.12,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.add_ic_call_outlined,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (width > displaysize.width * .2 + 8)
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Opacity(
                                              opacity:
                                                  ((width -
                                                              displaysize
                                                                      .width *
                                                                  .2) /
                                                          (displaysize.width *
                                                                  .8 -
                                                              displaysize
                                                                      .width *
                                                                  .2))
                                                      .clamp(0.0, 1.0),
                                              child: Text(
                                                'apple',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
