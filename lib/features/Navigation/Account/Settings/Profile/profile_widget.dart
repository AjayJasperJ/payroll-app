import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/core/constants/sizes.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class ExpandableCard extends StatelessWidget {
  final bool expanded;
  final String title;
  final double maxExpandHeight;
  final double normalHeight;
  final double normalWidth;
  final Color backgroundColor;
  final Widget child;
  final VoidCallback onExpand;
  final VoidCallback onShrink;

  const ExpandableCard({
    super.key,
    required this.expanded,
    required this.title,
    required this.maxExpandHeight,
    required this.normalHeight,
    required this.normalWidth,
    required this.backgroundColor,
    required this.child,
    required this.onExpand,
    required this.onShrink,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Click outside to shrink
        if (expanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: onShrink,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
        Align(
          alignment: Alignment.topCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            width: normalWidth,
            height: expanded ? maxExpandHeight : normalHeight,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: normalHeight,
                  width: normalWidth,
                  padding: EdgeInsets.symmetric(horizontal: width_main * .04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(title, size: AppSizes.titleLarge(context)),
                      Image.asset(Appicons.edit, height: displaysize.height * .025),
                    ],
                  ),
                ),
                IgnorePointer(
                  ignoring: !expanded,
                  child: AnimatedOpacity(
                    opacity: expanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: EdgeInsets.only(top: normalHeight + 6),
                      child: SizedBox(
                        height: expanded ? (maxExpandHeight - normalHeight - 12) : 0,
                        child: SingleChildScrollView(child: child),
                      ),
                    ),
                  ),
                ),
                if (!expanded)
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(borderRadius: BorderRadius.circular(16), onTap: onExpand),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
