import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Payroll HR');
    setWindowMinSize(const Size(400, 850));
    setWindowMaxSize(const Size(400, 850));
  }

  runApp(const MyApp());
}
