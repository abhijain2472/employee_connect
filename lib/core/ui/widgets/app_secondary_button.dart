import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/sizing_util.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 80),
        padding: const EdgeInsets.symmetric(
          horizontal: Sp.px20,
          vertical: Sp.px12,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(AppRounding.px6),
        ),
        child: Text(
          title,
          style: context.appTextStyle.labelLarge?.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
