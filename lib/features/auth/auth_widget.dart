import 'package:flutter/widgets.dart';
import 'package:payroll_hr/app.dart';

class AuthWidget {
  static Path rectanglecirclebottom(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, displaysize.height * .2);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40, // control point further below for more pop
      size.width,
      displaysize.height * .2,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  static Widget upDownInfinite({required Widget child, double offset = 20}) {
    return _UpDownInfinite(offset: offset, child: child);
  }
}

class _UpDownInfinite extends StatefulWidget {
  final Widget child;
  final double offset;
  const _UpDownInfinite({required this.child, this.offset = 20});

  @override
  State<_UpDownInfinite> createState() => _UpDownInfiniteState();
}

class _UpDownInfiniteState extends State<_UpDownInfinite>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: -widget.offset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
