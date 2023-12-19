import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/sizing_util.dart';
import '../../../../core/ui/widgets/horizontal_divider.dart';
import '../../models/employee.dart';
import '../bloc/employee_bloc.dart';
import '../pages/add_employee_page.dart';
import 'employee_tile.dart';

class EmployeeListWithLabel extends StatelessWidget {
  final List<Employee> employees;
  final String label;

  const EmployeeListWithLabel({
    Key? key,
    required this.employees,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final employeeBloc = context.readBloc<EmployeeBloc>();
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Sp.px16),
          color: AppColors.dividerColor,
          child: Text(
            label,
            style: context.appTextStyle.titleMedium?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final employee = employees.elementAt(index);
            return EmployeeTile(
              key: Key('e$employee.employeeId'),
              employee: employee,
              onDelete: () =>
                  employeeBloc.add(DeleteEmployee(employee: employee)),
              onTap: () => context.push(AddEmployeePage(employee: employee)),
            );
          },
          separatorBuilder: (_, __) => const HorizontalDivider(),
          itemCount: employees.length,
        ),
      ],
    );
  }
}
