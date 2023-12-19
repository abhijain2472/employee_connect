import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/app_assets.dart';
import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:employee_connect/core/ui/sizing_util.dart';
import 'package:employee_connect/core/ui/widgets/svg_icon.dart';
import 'package:employee_connect/feature/employee/models/employee.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/widgets/spacing.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({
    Key? key,
    required this.employee,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  final Employee employee;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: const DeleteView(),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            onDelete();
          }
        },
        key: ValueKey(employee.employeeId),
        child: Container(
          padding: const EdgeInsets.all(Sp.px16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name,
                style: context.appTextStyle.bodyLarge?.copyWith(
                  color: AppColors.blackTextColor,
                ),
              ),
              const Space.vertical(Sp.px6),
              Text(
                employee.employeeRole.label,
                style: context.appTextStyle.bodyMedium?.copyWith(
                  color: AppColors.hintColor,
                ),
              ),
              const Space.vertical(Sp.px6),
              Text(
                employee.durationText,
                style: context.appTextStyle.bodySmall?.copyWith(
                  color: AppColors.hintColor,
                ),
              ),
              const Space.vertical(Sp.px6),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteView extends StatelessWidget {
  const DeleteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Padding(
            padding: EdgeInsets.only(right: Sp.px16),
            child: SvgIcon(icon: AppAssets.delete),
          )
        ],
      ),
    );
  }
}
