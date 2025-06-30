import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class NavigationSidebar extends StatelessWidget {
  final double width;
  final double height;
  final double notificationbarHeight;
  final VoidCallback onToggle;
  final Function onIndex;
  final double constraintsh;
  final Animation<double> sidebarWidthAnim;
  final double notificationbar_height;
  final List icons;
  final List titles;
  final int selected_index;

  const NavigationSidebar({
    super.key,
    required this.width,
    required this.height,
    required this.notificationbarHeight,
    required this.onToggle,
    required this.onIndex,
    required this.constraintsh,
    required this.sidebarWidthAnim,
    required this.notificationbar_height,
    required this.icons,
    required this.titles,
    required this.selected_index,
  });

  @override
  Widget build(BuildContext context) {
    const double sidebarShadowStartWidth = 90;
    const double sidebarMaxShadow = 20;

    return AnimatedBuilder(
      animation: sidebarWidthAnim,
      builder: (context, child) {
        final double width = sidebarWidthAnim.value;
        double shadow = 0;
        if (width > sidebarShadowStartWidth) {
          final double t =
              ((width - sidebarShadowStartWidth) /
                      (displaysize.width * .8 - sidebarShadowStartWidth))
                  .clamp(0.0, 1.0);
          shadow = t * sidebarMaxShadow;
        }
        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          elevation: 0,
          child: Container(
            height: height - constraintsh * .02,
            width: width,
            margin: EdgeInsets.only(
              left: constraintsh * .01,
              bottom: constraintsh * .01,
              top: notificationbar_height + constraintsh * .01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: shadow > 0
                  ? [
                      BoxShadow(
                        color: Colors.black26.withOpacity(shadow / sidebarMaxShadow * 0.5),
                        blurRadius: shadow,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              children: [
                SizedBox(height: displaysize.height * .05),
                Column(
                  children: List.generate(icons.length + 1, (i) {
                    if (i == 0) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: displaysize.width * .2 - constraintsh * .01,
                                child: Center(
                                  child: SizedBox(
                                    width: displaysize.height * .04,
                                    height: displaysize.height * .04,
                                    child: InkWell(
                                      onTap: onToggle,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Center(
                                        child: Image.asset(
                                          Appicons.rightArrowDouble,
                                          height: displaysize.height * .012,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (width > displaysize.width * .2 + 8)
                                const Expanded(child: SizedBox()),
                            ],
                          ),
                          SizedBox(height: displaysize.height * .05),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: displaysize.width * .2 - constraintsh * .01,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () => onIndex(i + 2),
                                    child: Card(
                                      elevation: 0,
                                      color: sidebarWidthAnim.value < 80
                                          ? selected_index == (i + 2)
                                                ? Theme.of(context).cardColor
                                                : Colors.transparent
                                          : Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: displaysize.height * .04,
                                          height: displaysize.height * .04,
                                          child: Image.asset(
                                            icons[i - 1],
                                            height: displaysize.height * .04,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (width > displaysize.width * .2 + 8)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Opacity(
                                        opacity:
                                            ((width - displaysize.width * .2) /
                                                    (displaysize.width * .8 -
                                                        displaysize.width * .2))
                                                .clamp(0.0, 1.0),
                                        child: Txt(
                                          titles[i - 1],
                                          max: 1,
                                          clip: TextOverflow.ellipsis,
                                          size: AppSizes.titleLarge(context),
                                          font: Font.regular,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: displaysize.height * .05),
                        ],
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
