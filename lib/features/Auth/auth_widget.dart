import 'package:flutter/material.dart';
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

  static Path curtainFullEdge(Size size, double curtainTop) {
    final path = Path();
    // Start at top left
    path.moveTo(0, 0);
    // Left edge down to curtainTop
    path.lineTo(0, curtainTop);
    // Draw a smooth curve for the curtain edge
    path.quadraticBezierTo(
      size.width / 2,
      curtainTop + 40, // control point below the curtainTop for a nice curve
      size.width,
      curtainTop,
    );
    // Right edge up to top right
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  static Widget upDownInfinite({required Widget child, double offset = 20}) {
    return _UpDownInfinite(offset: offset, child: child);
  }

  static Widget SlidableCurtainWidget({
    required Color color,
    required Widget child,
    required Widget buttonwidget,
    void Function()? onFullyExpanded,
    Widget? targetPage, // New: page to push after full expand
  }) {
    return _SlidableCurtainWidget(
      buttonwidget: buttonwidget,
      color: color,
      initialHeightRatio: 0.3,
      minHeightRatio: .2,
      maxHeightRatio: 1,
      circleRadius: 10,
      onFullyExpanded: onFullyExpanded,
      child: child,
      targetPage: targetPage, // Pass to widget
    );
  }
}

class _UpDownInfinite extends StatefulWidget {
  final Widget child;
  final double offset;
  const _UpDownInfinite({required this.child, this.offset = 20});

  @override
  State<_UpDownInfinite> createState() => _UpDownInfiniteState();
}

class _UpDownInfiniteState extends State<_UpDownInfinite> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
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
        return Transform.translate(offset: Offset(0, _animation.value), child: child);
      },
      child: widget.child,
    );
  }
}

class _SlidableCurtainWidget extends StatefulWidget {
  final Color color;
  final Widget? child;
  final Widget? buttonwidget;
  final double initialHeightRatio; // 0.0 to 1.0
  final double minHeightRatio; // 0.0 to 1.0
  final double maxHeightRatio; // 0.0 to 1.0
  final double circleRadius;
  final void Function()? onFullyExpanded;
  final Widget? targetPage; // New: page to push after full expand

  const _SlidableCurtainWidget({
    required this.color,
    required this.child,
    required this.buttonwidget,
    required this.initialHeightRatio,
    required this.minHeightRatio,
    required this.maxHeightRatio,
    required this.circleRadius,
    this.onFullyExpanded,
    this.targetPage,
  });

  @override
  State<_SlidableCurtainWidget> createState() => __SlidableCurtainWidgetState();
}

class __SlidableCurtainWidgetState extends State<_SlidableCurtainWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 1.0;
  bool _hasCalledFullyExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: widget.minHeightRatio,
      upperBound: widget.maxHeightRatio,
      value: widget.initialHeightRatio,
    );
    _controller.addListener(_handleCurtainProgress);
  }

  void _handleCurtainProgress() {
    if (_controller.value >= 0.999 && !_hasCalledFullyExpanded) {
      _hasCalledFullyExpanded = true;
      if (widget.onFullyExpanded != null) widget.onFullyExpanded!();
      setState(() {
        _opacity = 0.0;
      });
      // New: Push target page with fade transition if provided
      if (widget.targetPage != null) {
        Future.delayed(const Duration(milliseconds: 350), () {
          if (mounted) {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(opacity: animation, child: widget.targetPage!);
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return Stack(
                    children: [
                      FadeTransition(
                        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Container(color: Colors.transparent),
                        ),
                      ),
                      FadeTransition(opacity: animation, child: child),
                    ],
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          }
        });
      }
    } else if (_controller.value < 0.999) {
      _hasCalledFullyExpanded = false;
      setState(() {
        _opacity = 1.0;
      });
    }
  }

  void _expandCurtain() {
    _controller.animateTo(widget.maxHeightRatio, curve: Curves.easeInOut);
  }

  void _collapseCurtain() {
    _controller.animateTo(widget.initialHeightRatio, curve: Curves.easeInOut);
  }

  void _onDragUpdate(DragUpdateDetails details, double screenHeight) {
    final delta = details.primaryDelta! / screenHeight;
    // Use a percentage of screenHeight for arc geometry to be responsive
    final double minArcHeight = screenHeight * 0.28; // 28% of screen height
    final double minCurtainRatio = minArcHeight / screenHeight;
    final newValue = (_controller.value + delta).clamp(minCurtainRatio, widget.maxHeightRatio);
    _controller.value = newValue;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta != null && details.primaryDelta! < -10) {
      _collapseCurtain();
    }
  }

  void _onVerticalDragEnd(DragEndDetails details, double screenHeight) {
    if (_controller.value >= 0.6) {
      _expandCurtain();
    } else {
      _collapseCurtain();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleCurtainProgress);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 350),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final curtainHeight = size.height * _controller.value;
              return Stack(
                children: [
                  ClipPath(
                    clipper: _ThreeSideRectOneCircleClipper(
                      height: curtainHeight,
                      circleRadius: widget.circleRadius,
                    ),
                    child: Container(
                      width: size.width,
                      height: curtainHeight,
                      color: widget.color,
                      child: widget.child,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: widget.circleRadius * 2,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) => _onDragUpdate(details, size.height),
                      onHorizontalDragUpdate: _onHorizontalDragUpdate,
                      onVerticalDragEnd: (details) => _onVerticalDragEnd(details, size.height),
                      onTap: _expandCurtain,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [if (widget.buttonwidget != null) widget.buttonwidget!],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ThreeSideRectOneCircleClipper extends CustomClipper<Path> {
  final double height;
  final double circleRadius;
  _ThreeSideRectOneCircleClipper({required this.height, required this.circleRadius});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double t = (height / displaysize.height).clamp(0.0, 1.0);
    // Use a curve for a smooth transition
    final double maxArcDepth = (size.height * 0.28).clamp(100.0, 320.0);
    final double arcDepth = maxArcDepth * (1 - Curves.easeInOut.transform(t));
    final double arcY = height - arcDepth;
    path.moveTo(0, 0);
    if (arcDepth > 1.0) {
      // Smooth, round bottom edge with eased control point
      path.lineTo(0, arcY);
      path.quadraticBezierTo(
        size.width / 2,
        arcY + arcDepth * (1.2 + 0.8 * (1 - Curves.easeInOut.transform(t))),
        size.width,
        arcY,
      );
      path.lineTo(size.width, 0);
    } else {
      // Fully expanded, flat bottom
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_ThreeSideRectOneCircleClipper oldClipper) {
    return oldClipper.height != height || oldClipper.circleRadius != circleRadius;
  }
}
