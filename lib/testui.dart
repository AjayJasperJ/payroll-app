import 'package:flutter/material.dart';
import 'package:payroll_hr/features/Navigation/Account/Settings/Profile/profile_widget.dart';

class Testui extends StatefulWidget {
  const Testui({super.key});

  @override
  State<Testui> createState() => _TestuiState();
}

class _TestuiState extends State<Testui> with SingleTickerProviderStateMixin {
  bool _expanded = false;
  String _personName = 'John Doe';
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _expand() {
    setState(() {
      _controller.text = _personName;
      _expanded = true;
    });
  }

  void _shrink() {
    setState(() {
      _expanded = false;
    });
  }

  void _save() {
    final trimmed = _controller.text.trim();
    if (trimmed.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name cannot be empty!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      _personName = trimmed;
      _expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ExpandableCard(
            expanded: _expanded,
            title: _personName,
            maxExpandHeight: 150,
            normalHeight: 30,
            normalWidth: 200,
            backgroundColor: Colors.blue,
            onExpand: _expand,
            onShrink: _shrink,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Person Name',
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 30,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name required';
                      }
                      if (value.trim().length < 2) {
                        return 'Too short';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _shrink,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Dismiss'),
                    ),
                    ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
