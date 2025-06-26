import 'package:flutter/material.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class SwipeToActionWidget
    extends
        StatefulWidget {
  final bool doubleSide; // true: both sides, false: single side
  final bool swipeRight; // only used if doubleSide is false
  final double width;
  final double height;
  final Color backgroundColor;
  final Color swipeButtonColor;
  final String label1; // single side: main label, double: left label
  final String label2; // single side: confirm label, double: right label
  final VoidCallback onSwipe;

  const SwipeToActionWidget({
    super.key,
    this.doubleSide = false,
    this.swipeRight = true,
    this.width = 300,
    this.height = 50,
    this.backgroundColor = Colors.black12,
    this.swipeButtonColor = Colors.white,
    this.label1 = '',
    this.label2 = '',
    required this.onSwipe,
  });

  @override
  State<
    SwipeToActionWidget
  >
  createState() => _SwipeToActionWidgetState();
}

class _SwipeToActionWidgetState
    extends
        State<
          SwipeToActionWidget
        > {
  late double _dragX;
  bool _completed = false;
  @override
  void initState() {
    super.initState();
    _dragX = _getInitialDragX();
  }

  double _getInitialDragX() {
    if (widget.doubleSide) {
      return (widget.width -
              widget.height) /
          2; // default width/height, will be replaced by actual
    }
    return widget.swipeRight
        ? 0.0
        : widget.width -
              widget.height;
  }

  void _reset() {
    setState(
      () {
        _dragX = _getInitialDragX();
        _completed = false;
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final width = widget.width;
    final height = widget.height;
    final minX = 0.0;
    final maxX =
        width -
        height;
    final centerX =
        (width -
            height) /
        2;
    final percent = widget.doubleSide
        ? (_dragX -
                  centerX) /
              centerX
        : widget.swipeRight
        ? (_dragX -
                  minX) /
              (maxX -
                  minX)
        : (maxX -
                  _dragX) /
              (maxX -
                  minX);
    Color bgColor = widget.backgroundColor;
    IconData icon = widget.doubleSide
        ? Icons.drag_handle
        : (widget.swipeRight
              ? Icons.arrow_forward
              : Icons.arrow_back);
    if (widget.doubleSide) {
      if (percent <
          -0.2) {
        bgColor = Colors.red.withOpacity(
          0.7,
        );
        icon = Icons.close;
      } else if (percent >
          0.2) {
        bgColor = Colors.green.withOpacity(
          0.7,
        );
        icon = Icons.check;
      }
    } else if (widget.swipeRight &&
        _dragX >
            minX +
                10) {
      icon = Icons.check;
    } else if (!widget.swipeRight &&
        _dragX <
            maxX -
                10) {
      icon = Icons.check;
    }

    // Headings logic (single side, as per user request)
    final heading1 = widget.label1;
    final heading2 = widget.label2;
    final double headingHeight =
        height *
        0.7;
    double fade1 = 1.0;
    double fade2 = 0.0;
    double offset1 = 0.0;
    double offset2 = headingHeight;
    if (!widget.doubleSide) {
      // 0-0.5: label1 swipes up and fades out, 0.5-1: label2 swipes in from bottom to center and stays centered
      final t = percent.clamp(
        0.0,
        1.0,
      );
      if (t <=
          0.5) {
        fade1 =
            1.0 -
            (t *
                2);
        fade2 = 0.0;
        offset1 =
            -t *
            2 *
            headingHeight;
        offset2 = headingHeight; // Start label2 at bottom
      } else {
        fade1 = 0.0;
        fade2 =
            (t -
                0.5) *
            2;
        // label2 moves from bottom to center as t goes from 0.5 to 1.0
        offset1 = -headingHeight;
        offset2 =
            (1 -
                fade2) *
            headingHeight;
      }
    } else {
      // Double side: keep previous logic
      if (percent >=
          0) {
        fade1 =
            1.0 -
            percent
                .clamp(
                  0,
                  1,
                )
                .toDouble();
        fade2 = percent
            .clamp(
              0,
              1,
            )
            .toDouble();
        offset1 =
            -percent
                .clamp(
                  0,
                  1,
                )
                .toDouble() *
            headingHeight;
        offset2 =
            (1 -
                    percent
                        .clamp(
                          0,
                          1,
                        )
                        .toDouble()) *
                headingHeight -
            headingHeight;
      } else {
        fade1 = -percent
            .clamp(
              -1,
              0,
            )
            .toDouble();
        fade2 =
            1.0 +
            percent
                .clamp(
                  -1,
                  0,
                )
                .toDouble();
        offset1 =
            (1 +
                    percent
                        .clamp(
                          -1,
                          0,
                        )
                        .toDouble()) *
                -headingHeight +
            headingHeight;
        offset2 =
            -percent
                .clamp(
                  -1,
                  0,
                )
                .toDouble() *
            headingHeight;
      }
    }

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 120,
          ),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(
              height /
                  2,
            ),
          ),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (fade1 >
                  0.0)
                Transform.translate(
                  offset: Offset(
                    0,
                    offset1,
                  ),
                  child: Opacity(
                    opacity: fade1,
                    child: Txt(
                      heading1,
                      font: Font.bold,
                      size:
                          height *
                          0.35,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (fade2 >
                  0.0)
                Transform.translate(
                  offset: Offset(
                    0,
                    offset2,
                  ),
                  child: Opacity(
                    opacity: fade2,
                    child: Txt(
                      heading2,
                      font: Font.bold,
                      size:
                          height *
                          0.35,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          left:
              _dragX +
              4,
          top: 0,
          bottom: 0,
          child: GestureDetector(
            onHorizontalDragUpdate:
                (
                  details,
                ) {
                  setState(
                    () {
                      double newDragX =
                          _dragX +
                          details.delta.dx;
                      if (widget.doubleSide) {
                        _dragX = newDragX.clamp(
                          minX,
                          maxX,
                        );
                      } else if (widget.swipeRight) {
                        _dragX = newDragX.clamp(
                          minX,
                          maxX,
                        );
                      } else {
                        _dragX = newDragX.clamp(
                          minX,
                          maxX,
                        );
                      }
                    },
                  );
                },
            onHorizontalDragEnd:
                (
                  details,
                ) {
                  if (widget.doubleSide) {
                    if (_dragX <=
                        minX +
                            10) {
                      setState(
                        () => _completed = true,
                      );
                      Future.delayed(
                        const Duration(
                          milliseconds: 200,
                        ),
                        () {
                          widget.onSwipe();
                          _reset();
                        },
                      );
                    } else if (_dragX >=
                        maxX -
                            10) {
                      setState(
                        () => _completed = true,
                      );
                      Future.delayed(
                        const Duration(
                          milliseconds: 200,
                        ),
                        () {
                          widget.onSwipe();
                          _reset();
                        },
                      );
                    } else {
                      _reset();
                    }
                  } else if (widget.swipeRight &&
                      _dragX >=
                          maxX -
                              10) {
                    setState(
                      () => _completed = true,
                    );
                    Future.delayed(
                      const Duration(
                        milliseconds: 200,
                      ),
                      () {
                        widget.onSwipe();
                        _reset();
                      },
                    );
                  } else if (!widget.swipeRight &&
                      _dragX <=
                          minX +
                              10) {
                    setState(
                      () => _completed = true,
                    );
                    Future.delayed(
                      const Duration(
                        milliseconds: 200,
                      ),
                      () {
                        widget.onSwipe();
                        _reset();
                      },
                    );
                  } else {
                    _reset();
                  }
                },
            child: Container(
              width:
                  height -
                  8,
              height:
                  height -
                  8,
              decoration: BoxDecoration(
                color: widget.swipeButtonColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(
                      0,
                      2,
                    ),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: widget.doubleSide
                    ? (percent <
                              -0.2
                          ? Colors.red
                          : percent >
                                0.2
                          ? Colors.green
                          : Colors.grey)
                    : Colors.green,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
