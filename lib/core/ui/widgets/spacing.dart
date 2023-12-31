import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space.vertical(this.height, {super.key}) : width = 0;

  const Space.horizontal(this.width, {super.key}) : height = 0;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
