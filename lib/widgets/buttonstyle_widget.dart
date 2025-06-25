import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';

class ButtonstyleWidget {
  ButtonStyle elevated_filled_apptheme(context) {
    return ButtonStyle(
      // splashFactory: InkSplash.splashFactory,
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.primary,
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2);
        }
        return null;
      }),
    );
  }

  ButtonStyle elevated_boardered_apptheme(context) {
    return ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displaysize.width / 4),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.3,
          ),
        ),
      ),
      // splashFactory: InkSplash.splashFactory,
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.onPrimary,
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return Theme.of(context).colorScheme.primary.withValues(alpha: .2);
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
          borderRadius: BorderRadius.circular(displaysize.width / 4),
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
      ),
      // splashFactory: InkSplash.splashFactory,
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.surface,
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return Theme.of(
            context,
          ).colorScheme.surfaceContainer.withValues(alpha: .2);
        } else if (states.contains(WidgetState.hovered)) {
          return Theme.of(context).colorScheme.surface.withValues(alpha: .0);
        }
        return null;
      }),
    );
  }
}
