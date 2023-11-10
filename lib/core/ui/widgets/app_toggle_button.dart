import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:employee_connect/core/ui/sizing_util.dart';
import 'package:flutter/material.dart';

class AppToggleButton extends StatelessWidget {
  const AppToggleButton({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Sp.px8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.lightBlue,
          borderRadius: BorderRadius.circular(AppRounding.px4),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: context.appTextStyle.bodyMedium?.copyWith(
            color: isSelected ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
