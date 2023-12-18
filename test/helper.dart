import 'package:flutter/material.dart';

class TestableWidget extends StatelessWidget {
  const TestableWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }
}
