import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final Color? color;

  const HorizontalDivider({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors.dividerColor,
      width: double.infinity,
      height: 1,
    );
  }
}
