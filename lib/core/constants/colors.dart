import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color.fromRGBO(43, 127, 255, 1); //main elements
  static const background = Color.fromRGBO(249, 250, 251, 1); //bckground
  static const container = Color.fromRGBO(219, 234, 254, 1);
  //container,card,cirlcavatar etc
  static const inputcolor = Color.fromRGBO(240, 249, 255, 1); //textformfiled
  static const gradentbackground = LinearGradient(
    colors: [Color.fromRGBO(219, 230, 255, 1), Color.fromRGBO(241, 245, 249, 1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
