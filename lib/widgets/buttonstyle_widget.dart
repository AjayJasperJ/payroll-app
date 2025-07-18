import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'dart:math' as Math;

class Bstyle {
  static ButtonStyle elevated_filled_apptheme(context) {
    return ButtonStyle(
      // splashFactory: InkSplash.splashFactory,
      elevation: WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2);
        }
        return null;
      }),
    );
  }

  static ButtonStyle elevated_boardered_apptheme(context) {
    return ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      // splashFactory: InkSplash.splashFactory,
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.grey.withValues(alpha: .1);
        } else if (states.contains(WidgetState.hovered)) {
          return Theme.of(context).colorScheme.onPrimary.withValues(alpha: .0);
        }
        return null;
      }),
    );
  }

  ButtonStyle elevated_boardered_sociallogin(context) {
    return ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displaysize.width * .03),
          side: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
        ),
      ),
      // splashFactory: InkSplash.splashFactory,
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: .2);
        } else if (states.contains(WidgetState.hovered)) {
          return Theme.of(context).colorScheme.surface.withValues(alpha: .0);
        }
        return null;
      }),
    );
  }
}


class LighthousePainter extends CustomPainter {
  final double progress;
  LighthousePainter(this.progress);

  void _drawVArms(Canvas canvas, Offset center, double length, double leftArm, double rightArm) {
    final List<Color> colors = [
      const Color.fromARGB(255, 255, 80, 60), // Brighter red
      const Color.fromARGB(255, 255, 80, 180), // Brighter rose
      const Color.fromARGB(255, 3, 108, 255), // Brighter blue
      const Color.fromARGB(255, 0, 255, 120), // Pure, bright green
    ];
    // Place green further away from blue
    final List<double> angles = [
      leftArm,
      (leftArm + rightArm) / 2,
      rightArm,
      rightArm + 0.9, // move green further away from blue
    ];
    final List<double> opacities = [1, 1, 1, 1];
    final List<double> blurs = [25, 25, 25, 25]; // more blur for green
    final List<double> widths = [30, 30, 50, 10]; // thicker for green

    for (int i = 0; i < 4; i++) {
      final Paint paint = Paint()
        ..color = colors[i].withOpacity(opacities[i])
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurs[i])
        ..style = PaintingStyle.stroke
        ..strokeWidth = widths[i];
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angles[i]);
      canvas.drawLine(Offset.zero, Offset(length, 0), paint);
      canvas.restore();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double length = size.height * 0.95;
    final double vAngle = 1.25 + 0.15 * Math.sin(progress * 2 * Math.pi); // wider V
    final double irregularity = 0.22 + 0.08 * Math.cos(progress * 2 * Math.pi); // more irregular
    final double startAngle = progress * 2 * Math.pi;
    // Dynamic, irregular V arms
    final double leftArm = startAngle - vAngle / 2 + (Math.sin(progress * 6) * irregularity);
    final double rightArm = startAngle + vAngle / 2 + (Math.cos(progress * 5) * irregularity);
    _drawVArms(canvas, center, length, leftArm, rightArm);
  }

  @override
  bool shouldRepaint(covariant LighthousePainter oldDelegate) => true;
}
