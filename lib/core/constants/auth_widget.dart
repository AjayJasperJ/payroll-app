import 'package:flutter/widgets.dart';

class AuthWidget {
  static Path rectanglecirclebottom(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, 150);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40, // control point further below for more pop
      size.width,
      150,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
}
