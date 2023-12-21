import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:employee_connect/core/ui/sizing_util.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.tapKey,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Key? tapKey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: tapKey,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(minWidth: 80),
        padding: const EdgeInsets.symmetric(
          horizontal: Sp.px20,
          vertical: Sp.px12,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppRounding.px6),
        ),
        child: Text(
          title,
          style: context.appTextStyle.labelLarge?.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
