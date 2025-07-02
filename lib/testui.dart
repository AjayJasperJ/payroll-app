import 'package:flutter/material.dart';
import 'package:payroll_hr/app.dart';
import 'package:payroll_hr/widgets/custom_dropdown.dart';

class Testui extends StatelessWidget {
  const Testui({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> years = List.generate(10, (i) => (DateTime.now().year - i).toString());
    return Scaffold(body: Center());
  }
}
