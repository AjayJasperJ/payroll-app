import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/features/Auth/auth_screen.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Payroll HR');
    setWindowMinSize(const Size(400, 850));
    setWindowMaxSize(const Size(400, 850));
  } else {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    displaysize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payroll HR',
      themeMode: ThemeMode.light,
      theme: payroll_light(),
      darkTheme: payroll_dark(),
      home: AuthLayout(),
    );
  }
}
