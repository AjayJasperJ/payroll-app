import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payroll HR',
      home: Scaffold(
        appBar: AppBar(title: const Text('Payroll HR')),
        body: const Center(child: Text('Welcome to Payroll HR!')),
      ),
    );
  }
}
