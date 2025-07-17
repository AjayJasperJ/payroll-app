import 'package:flutter/material.dart';

class ListConfig extends StatelessWidget {
  final Widget child;
  const ListConfig({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: child,
      ),
    );
  }
}
